module Korekto
class Statement
  class Error < RuntimeError; end
  attr_reader :code,:title,:context,:regexp
  def initialize(statement, code, title, context)
    @statement,@code,@title,@context = statement,code,title,context
    @statement.freeze
    syntax_check
    @regexp = nil
    set_acceptance_code
    @code.freeze; @title.freeze; @regexp.freeze
  end

  def type              = @code[0]
  def to_s              = @statement
  def to_str            = @statement
  def match?(statement) = @regexp.match?(statement)
  def chars             = @statement.chars

  private

  def set_statement(code, support=nil, title=nil)
    @code = "#{code}#{ @context.length + 1 }"
    @code += "/#{support}" if support
    @title ||= title
  end

  def syntax_check
    @context.syntax.each do |rule|
      raise Error, "syntax: #{rule}" unless @statement.instance_eval(rule)
    rescue
      raise "#{$!.class}: #{rule}"
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
      raise "statement type #{@code[0]} not defined"
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

  def axiom
    @regexp = @context.s2r[@statement]
    set_statement('A')
  end

  def tautology
    all_defined
    axiom = @context.type('A').detect do |statement|
      statement.match? @statement
    end
    raise Error, "does not match any axiom" unless axiom
    support,title = axiom.code,axiom.title
    support,_ = support.split('/', 2)
    set_statement('T', support, title)
  end

  def inference
    @regexp = @context.s2r[@statement]
    set_statement('I')
  end

  def conclusion
    all_defined
    inference,s1,s2 = infer
    raise Error, "does not match any inference" unless inference
    cm,title = inference.code,inference.title
    c1,_ = s1.code; c1,_ = c1.split('/', 2)
    c2,_ = s2.code; c2,_ = c2.split('/', 2)
    support = [cm,c1,c2].join(',')
    set_statement('C', support, title)
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
    set_statement('E')
  end

  def instantiation
    raise Error, 'nothing to instantiate' if @context.symbols.undefined(@statement).empty?
    existential,s1 = heap_search('E')
    raise Error, 'does not match any existential' unless existential
    cm,title = existential.code,existential.title
    c1,_ = s1.code; c1,_ = c1.split('/',2)
    support = [cm,c1].join(',')
    set_statement('X', support, title)
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
    set_statement('M')
  end

  def result
    all_defined
    mapping,s1 = heap_search('M')
    raise Error, 'does not match any mapping' unless mapping
    cm,title = mapping.code,mapping.title
    c1,_ = s1.code; c1,_ = c1.split('/',2)
    support = [cm,c1].join(',')
    set_statement('R', support, title)
  end
end
end
