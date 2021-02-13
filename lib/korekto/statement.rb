module Korekto
class Statement
  class Error < RuntimeError; end
  S2R = StatementToRegexp.new
  attr_reader :code,:title,:context
  def initialize(statement, code, title, context)
    @statement,@code,@title,@context,@heap = statement,code,title,context,true
    @statement.freeze
    syntax_check
    set_acceptance_code
    @code.freeze; @title.freeze
    @context.heap.add self if @heap
  end

  def type
    @code[0]
  end

  def to_s
    @statement
  end

  def to_str
    @statement
  end

  def match?(statement)
    S2R[@statement].match? statement
  end

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
    @context.symbols.define! @statement
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
    S2R[@statement] # memoize/register
    @heap = false # Axioms are statements about single statements
    set_statement('A')
  end

  def tautology
    all_defined
    axiom = @context.type('A').detect do |statement|
      statement.match? @statement
    end
    raise Error, "does not match any axiom" unless axiom
    support,title = axiom.code.split(' ', 2)
    support,_ = support.split('/', 2)
    set_statement('T', support, title)
  end

  def inference
    S2R[@statement] # memoize/register
    @heap = false # Inference are statements about compound statements
    set_statement('I')
  end

  def conclusion
    all_defined
    inference,s1,s2 = infer
    raise Error, "does not match any inference" unless inference
    cm,title = inference.code.split(' ',2)
    c1,_ = s1.code.split(' ',2); c1,_ = c1.split('/', 2)
    c2,_ = s2.code.split(' ',2); c2,_ = c2.split('/', 2)
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
end
end
