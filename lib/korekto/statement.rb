module Korekto
class Statement
  attr_reader :code,:title,:regexp,:section,:statement_number

  # rubocop: disable Metrics/ParameterLists
  def initialize(statement,code,title,section,statement_number,context)
    @statement,@code,@title,@section,@statement_number,@context,@regexp =
      statement,code,title,section,statement_number,context,nil
    @statement.freeze; @section.freeze; @statement_number.freeze
    @title = @title.split(':',2).first if @title
    syntax_check unless @statement[0]=='/' &&
                        @statement[-1]=='/' &&
                        %w[A L M E I].include?(@code[0])
    set_acceptance_code
    @code.freeze; @title.freeze; @regexp.freeze
  end
  # rubocop: enable Metrics/ParameterLists

  def type              = @code[0]
  def to_s              = @statement
  def to_str            = @statement
  def match?(statement) = @regexp.match?(statement)
  def scan(regex, &)    = @statement.scan(regex, &)
  def pattern?          = !@regexp.nil?
  def literal_regexp?   = @statement[0]=='/' && @statement[-1]=='/'

  private

  def syntax_check
    @context.syntax.each do |rule|
      next if @statement.instance_eval(rule)
      raise Error, "syntax: #{rule}"
    rescue StandardError
      raise if $!.is_a? Error
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
      # Axiom=>Tautology, Let=>Set,
      pattern_type(0)
    when 'M', 'E'
      # Map=>Result, Existential=>Instantiation(X)
      pattern_type(1)
    when 'I'
      # Inference=>Conclusion
      pattern_type(2)
    when 'W'
      %w[T S R X C].any? do |code|
        @code[0]=code
        set_acceptance_code
        true
      rescue Error
        false
      end or raise Error, 'did not match any statement pattern'
    else
      raise Error, "statement type #{@code[0]} not implemented"
    end
  end

  # Common helper

  def set_statement(support=nil, title=nil)
    @code = "#{@code[0]}#{@statement_number}"
    @code += '.' + @section unless @section=='-'
    @code += "/#{support}" if support
    @title = title if (title=title&.split(':',2)&.first) && !title.empty?
  end

  def support(*s) = s.inject([]){|a,s| a.push(s.code.split('/',2)[0])}.join(',')

  # Pattern helpers

  def newlines_count(n)
    unless n==@regexp.inspect.gsub('\\\\','').scan('\\n').length
      raise Error, "expected #{n} newlines"
    end
  end

  def set_regexp
    @regexp = @context.symbols.s2r(@statement)
  end

  # Searches

  def detect_statement(type)
    @context.type(type).detect{_1.match? @statement} ||
      raise(Error, "does not match any '#{type}' statement")
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
      unless n==undefined.length
        raise Error, "expected #{n} undefined: #{undefined.join(' ')}"
      end
    elsif undefined.empty?
      raise Error, 'nothing was undefined'
    end
  end

  def undefined_in_pattern
    undefined = @context.symbols.undefined(self)
    @title = "#{@title}: #{undefined.join(' ')}" unless undefined.empty?
  end

  # Statement type processing

  def pattern_type(nl)
    set_regexp
    newlines_count(nl)
    undefined_in_pattern
    follows = @context.heap.to_a[0..nl].reverse
    if @regexp.match? follows.map(&:to_s).join("\n")
      set_statement(support(*follows))
    else
      set_statement
    end
  end

  # A Tautology is an accepted true statement that immediately follows from
  # an Axiom rule. It may not have any undefined terms.
  def tautology
    expected_instantiations(n:0)
    axiom = detect_statement('A')
    set_statement(support(axiom), axiom.title)
  end

  # A Set(Assignment) is an allowed true statement that introduces at least one
  # term as immediately validated by a matching Let rule.
  def set
    let = detect_statement('L')
    expected_instantiations(let.title)
    set_statement(support(let), let.title)
  end

  # A Result is a derived true statement that follows from a Map rule and
  # matching true statement.
  def result
    expected_instantiations(n:0)
    mapping,s1 = heap_search('M')
    set_statement(support(mapping,s1), mapping.title)
  end

  # An Instantiation is a derived true statement that introduces at least one
  # new term as a result of an Existential rule and matching true statement.
  def instantiation
    existential,s1 = heap_search('E')
    expected_instantiations(existential.title)
    set_statement(support(existential,s1), existential.title)
  end

  # A Conclusion is a derived true statement, the result of an Inference rule
  # that follows from two true statements.
  def conclusion
    expected_instantiations(n:0)
    inference,s1,s2 = heap_combos_search('I')
    set_statement(support(inference,s1,s2), inference.title)
  end

  # A Definition is an assumed true statement that defines at least one term.
  def definition
    expected_instantiations(@title)
    set_statement
  end

  # A Postulate is an assumed true statement with all terms defined.
  def postulate
    expected_instantiations(n:0)
    set_statement
  end
end
end
