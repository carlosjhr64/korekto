module Korekto
class Statement
  attr_reader :code,:title,:regexp,:filename,:statement_number
  def initialize(statement,code,title,filename,statement_number,context)
    @statement,@code,@title,@statement_number,@context = statement,code,title,statement_number,context
    @filename = File.basename(filename,'.*')
    @statement.freeze; @filename.freeze; @statement_number.freeze
    syntax_check
    @regexp = nil
    set_acceptance_code
    @code.freeze; @title.freeze; @regexp.freeze
  end

  def type              = @code[0]
  def to_s              = @statement
  def to_str            = @statement
  def match?(statement) = @regexp.match?(statement)
  def scan(regex, &blk) = @statement.scan(regex, &blk)

  private

  def syntax_check
    @context.syntax.each do |rule|
      raise Error, "syntax: #{rule}" unless @statement.instance_eval(rule)
    rescue # other than Korekto::Error < Exception
      raise Error, "#{$!.class}: #{rule}"
    end
  end

  def set_acceptance_code
    case @code[0] # type
    when 'D'
      definition
    when 'P'
      postulate
    when 'L'
      pattern_type(0)
    when 'S'
      set
    when 'A'
      pattern_type(0)
    when 'T'
      tautology
    when 'I'
      pattern_type(2)
    when 'C'
      conclusion
    when 'E'
      pattern_type(1)
    when 'X'
      instantiation
    when 'M'
      pattern_type(1)
    when 'R'
      result
    else
      raise Error, "statement type #{@code[0]} not implemented"
    end
  end

  # Helper functions
 
  def set_statement(support=nil, title=nil)
    @code = "#{@code[0]}#{@statement_number}"
    @code += "/#{support}" if support
    @title = title if title
  end

  def all_defined
    unless (u = @context.symbols.undefined(@statement)).empty?
      raise Error, "undefined: #{u.join(' ')}"
    end
  end

  def newlines_count(n)
    raise Error, "expected #{n} newlines" unless n==@regexp.inspect.gsub('\\\\','').scan('\\n').length
  end

  def set_regexp
    @regexp = @context.symbols.s2r(@statement)
  end

  def support(*s)
    support = []
    s.each do |s|
      c = s.code.split('/',2)[0]
      c = s.filename+'.'+c unless s.filename=='-'
      support.push(c)
    end
    return support.join(',')
  end

  def expected_instantiations(title=@title)
    undefined = @context.symbols.undefined(@statement)
    raise Error, 'nothing was undefined' if undefined.empty?
    if n = title&.match(/\d/)&.to_s&.to_i and not n==undefined.length
      raise Error, "expected #{n} instantiations, got: #{undefined.join(' ')}"
    end
  end

  def detect_statement(type)
    statement = @context.type(type).detect do |statement|
      statement.match? @statement
    end
    raise Error, "does not match any '#{type}' statement" unless statement
    return statement
  end

  def heap_combos_search(type)
    @context.heap.combos do |s1, s2|
      compound = [s1,s2,@statement].join("\n")
      @context.type(type).each do |inference|
        return inference,s1,s2 if inference.match?(compound)
      end
    end
    raise Error, "does not match any '#{type}' statement"
  end

  def heap_search(type)
    @context.heap.each do |s1|
      compound = [s1,@statement].join("\n")
      @context.type(type).each do |s0|
        return s0,s1 if s0.match?(compound)
      end
    end
    raise Error, "does not match any '#{type}' statement"
  end

  # Statement type processing

  def pattern_type(nl)
    set_regexp
    newlines_count(nl)
    set_statement
  end

  def definition
    expected_instantiations
    set_statement
  end

  def set
    let = detect_statement('L')
    expected_instantiations(let.title)
    set_statement(support(let), let.title)
  end

  def instantiation
    existential,s1 = heap_search('E')
    expected_instantiations(existential.title)
    set_statement(support(existential,s1), existential.title)
  end

  def conclusion
    all_defined
    inference,s1,s2 = heap_combos_search('I')
    set_statement(support(inference,s1,s2), inference.title)
  end

  def result
    all_defined
    mapping,s1 = heap_search('M')
    set_statement(support(mapping,s1), mapping.title)
  end

  def tautology
    all_defined
    axiom = detect_statement('A')
    set_statement(support(axiom), axiom.title)
  end

  def postulate
    all_defined
    set_statement
  end
end
end
