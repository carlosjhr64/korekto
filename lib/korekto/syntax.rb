module Korekto
class Syntax
  def initialize = @syntax=[]
  def to_a = @syntax

  using Refinements

  def push(s)
    raise Error, 'duplicate syntax' if @syntax.include?(s)
    # ensure it'll eval on string and returns boolean
    b = ''.instance_eval(s)
    # rubocop: disable Style/DoubleNegation
    raise Error, 'syntax must eval boolean' unless b==!!b
    # rubocop: enable Style/DoubleNegation
    @syntax.push(s)
  rescue StandardError
    raise if $!.is_a? Error
    raise Error, "#{$!.class}: #{s}"
  end

  def detect(statement, boolean)
    @syntax.detect do |syntax|
        statement.instance_eval(syntax) == boolean
    rescue StandardError
      raise if $!.is_a? Error # Why would it be this?
      raise Error, "#{$!.class}: #{syntax}"
    end
  end
end
end
