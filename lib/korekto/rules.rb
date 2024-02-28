module Korekto
class Rules
  def initialize = @a=[]
  def to_a = @a

  using Refinements

  def push(s)
    # ensure it'll eval on string and returns boolean
    b = ''.instance_eval(s)
    # rubocop: disable Style/DoubleNegation
    raise Error, 'rules must eval boolean' unless b==!!b
    # rubocop: enable Style/DoubleNegation
    @a.push(s)
  rescue StandardError
    raise if $!.is_a? Error
    raise Error, "#{$!.class}: #{s}"
  end

  def detect(statement, boolean)
    @a.detect do |rule|
        statement.instance_eval(rule) == boolean
    rescue StandardError
      raise if $!.is_a? Error # Why would it be this?
      raise Error, "#{$!.class}: #{rule}"
    end
  end
end
end
