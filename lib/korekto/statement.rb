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

  def set_statement(code, support=nil, title=nil)
    @code = "#{code}#{@statement_number}"
    @code += "/#{support}" if support
    @title = title if title
  end

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
    when 'A'
      axiom
    when 'T'
      tautology
    when 'I'
      inference
    when 'C'
      conclusion
    when 'E'
      existential
    when 'X'
      instantiation
    when 'M'
      mapping
    when 'R'
      result
    else
      raise Error, "statement type #{@code[0]} not implemented"
    end
  end

=begin
    # TODO: not sure I want this
    def tautology?
      @context.type('A').any?{|statement| statement.match? @statement}
    end

    def inferable?
      mapping,*_ = infer
      not mapping.nil?
    end

    def assert_not_provable
      raise Error, 'tautology' if tautology?
      raise Error, 'inferable' if inferable?
    end
=end

  def definition
    raise Error, 'nothing was undefined' if @context.symbols.undefined(@statement).empty?
#   assert_not_provable unless OPTIONS.fast?
    set_statement('D')
  end

  def all_defined
    unless (u = @context.symbols.undefined(@statement)).empty?
      raise Error, "undefined: #{u.join(' ')}"
    end
  end

  def postulate
    all_defined
#   assert_not_provable unless OPTIONS.fast?
    set_statement('P')
  end

  def newlines_count(n)
    raise Error, "expected #{n} newlines" unless n==@regexp.inspect.gsub('\\\\','').scan('\\n').length
  end

  def axiom
    @regexp = @context.s2r[@statement]
    newlines_count(0)
    set_statement('A')
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

  def tautology
    all_defined
    axiom = @context.type('A').detect do |statement|
      statement.match? @statement
    end
    raise Error, "does not match any axiom" unless axiom
    set_statement('T', support(axiom), axiom.title)
  end

  def inference
    @regexp = @context.s2r[@statement]
    newlines_count(2)
    set_statement('I')
  end


  def conclusion
    all_defined
    inference,s1,s2 = infer
    raise Error, "does not match any inference" unless inference
    set_statement('C', support(inference,s1,s2), inference.title)
  end

  def infer
    @context.heap.combos do |s1, s2|
      compound = [s1,s2,@statement].join("\n")
      @context.type('I').each do |inference|
        return inference,s1,s2 if inference.match?(compound)
      end
    end
    return nil
  end

  def existential
    @regexp = @context.s2r[@statement]
    newlines_count(1)
    set_statement('E')
  end

  def instantiation
    undefined = @context.symbols.undefined(@statement)
    raise Error, 'nothing to instantiate' if undefined.empty?
    existential,s1 = heap_search('E')
    raise Error, 'does not match any existential' unless existential
    if n = existential.title&.match(/\d/)&.to_s&.to_i and not n==undefined.length
      raise Error, "expected #{n} instantiations, got: #{undefined.join(' ')}"
    end
    set_statement('X', support(existential,s1), existential.title)
  end

  def heap_search(type)
    @context.heap.each do |s1|
      compound = [s1,@statement].join("\n")
      @context.type(type).each do |s0|
        return s0,s1 if s0.match?(compound)
      end
    end
    return nil
  end

  def mapping
    @regexp = @context.s2r[@statement]
    newlines_count(1)
    set_statement('M')
  end

  def result
    all_defined
    mapping,s1 = heap_search('M')
    raise Error, 'does not match any mapping' unless mapping
    set_statement('R', support(mapping,s1), mapping.title)
  end
end
end
