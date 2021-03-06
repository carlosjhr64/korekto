module Korekto
class Statement
  attr_reader :code,:title,:regexp,:section,:statement_number
  def initialize(statement,code,title,section,statement_number,context)
    @statement,@code,@title,@section,@statement_number,@context =
      statement,code,title,section,statement_number,context
    @statement.freeze; @section.freeze; @statement_number.freeze
    syntax_check unless @statement[0]=='/' and @statement[-1]=='/' and ['A','L','M','E','I'].include?(@code[0])
    @regexp = nil
    set_acceptance_code
    @code.freeze; @title.freeze; @regexp.freeze
  end

  def type              = @code[0]
  def to_s              = @statement
  def to_str            = @statement
  def match?(statement) = @regexp.match?(statement)
  def scan(regex, &blk) = @statement.scan(regex, &blk)
  def pattern?          = !@regexp.nil?
  def literal_regexp?   = @statement[0]=='/' && @statement[-1]=='/'

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
    when 'P'
      postulate
    when 'D'
      definition
    when 'C'
      conclusion
    when 'X'
      instantiation
    when 'R'
      result
    when 'S'
      set
    when 'T'
      tautology
    when 'A', 'L'
      # Axiom=>Tautoloty, Let=>Set,
      pattern_type(0)
    when 'M', 'E'
      # Map=>Result, Existential=>Instantiation(X)
      pattern_type(1)
    when 'I'
      # Inference=>Conclusion
      pattern_type(2)
    when 'W'
      ['T','S','R','X','C'].any? do |code|
        begin
          @code[0]=code
          set_acceptance_code
          true
        rescue Error
          false
        end
      end or raise Error, 'did not match any statement pattern'
    else
      raise Error, "statement type #{@code[0]} not implemented"
    end
  end

  # Common helper

  def set_statement(support=nil, title=nil)
    @code = "#{@code[0]}#{@statement_number}"
    @code += "/#{support}" if support
    @title = title.split(':',2).first if title
  end

  def support(*s)
    support = []
    s.each do |s|
      c = s.code.split('/',2)[0]
      c = s.section+'.'+c unless s.section=='-'
      support.push(c)
    end
    return support.join(',')
  end

  # Pattern helpers

  def newlines_count(n)
    raise Error, "expected #{n} newlines" unless n==@regexp.inspect.gsub('\\\\','').scan('\\n').length
  end

  def set_regexp
    @regexp = @context.symbols.s2r(@statement)
  end

  # Searches

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

  # Defined/Undefined

  def expected_instantiations(title=nil, n:nil)
    undefined = @context.symbols.undefined(self)
    if n ||= title&.match(/[1-9]\d*/)&.to_s&.to_i
      raise Error, "expected #{n} undefined: #{undefined.join(' ')}" unless n==undefined.length
    else
      raise Error, 'nothing was undefined' if undefined.empty?
    end
  end

  def undefined_in_pattern
    @title = @title.split(':',2).first if @title
    undefined = @context.symbols.undefined(self)
    @title = "#{@title}: #{undefined.join(' ')}" unless undefined.empty?
  end

  # Statement type processing

  def pattern_type(nl)
    set_regexp
    newlines_count(nl)
    undefined_in_pattern
    set_statement
  end

  def tautology
    expected_instantiations(n:0)
    axiom = detect_statement('A')
    set_statement(support(axiom), axiom.title)
  end

  def set
    let = detect_statement('L')
    expected_instantiations(let.title)
    set_statement(support(let), let.title)
  end

  def result
    expected_instantiations(n:0)
    mapping,s1 = heap_search('M')
    set_statement(support(mapping,s1), mapping.title)
  end

  def instantiation
    existential,s1 = heap_search('E')
    expected_instantiations(existential.title)
    set_statement(support(existential,s1), existential.title)
  end

  def conclusion
    expected_instantiations(n:0)
    inference,s1,s2 = heap_combos_search('I')
    set_statement(support(inference,s1,s2), inference.title)
  end

  def definition
    expected_instantiations(@title)
    set_statement
  end

  def postulate
    expected_instantiations(n:0)
    set_statement
  end
end
end
