module Korekto
class Syntax
  def initialize = @syntax=[]
  def to_a = @syntax

  using Refinements

  def push(rule)
    raise Error, 'duplicate syntax' if @syntax.include?(rule)
    # ensure it'll eval on string and returns boolean
    b = ''.instance_eval(rule)
    # rubocop: disable Style/DoubleNegation
    raise Error, 'syntax must eval boolean' unless b==!!b
    # rubocop: enable Style/DoubleNegation
    @syntax.push(rule)
  rescue StandardError
    raise if $!.is_a? Error
    raise Error, "#{$!.class}: #{rule}"
  end

  def check(statement)
    rule = @syntax.detect do |rule|
      !statement.instance_eval rule
    rescue StandardError
      raise Error, "#{$!.class}: #{rule}"
    end
    raise Error, "syntax: #{rule}" if rule
  end
end
end
