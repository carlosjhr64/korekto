module Korekto
class Syntax
  def initialize = @a=[]
  def to_a = @a

  using Refinements

  def push(s)
    raise Error, 'duplicate syntax' if @a.include?(s)
    # ensure it'll eval on string and returns boolean
    b = ''.instance_eval(s)
    # rubocop: disable Style/DoubleNegation
    raise Error, 'syntax must eval boolean' unless b==!!b
    # rubocop: enable Style/DoubleNegation
    @a.push(s)
  rescue StandardError
    raise if $!.is_a? Error
    raise Error, "#{$!.class}: #{s}"
  end

  def detect(statement, boolean)
    @a.detect do |syntax|
        statement.instance_eval(syntax) == boolean
    rescue StandardError
      raise if $!.is_a? Error # Why would it be this?
      raise Error, "#{$!.class}: #{syntax}"
    end
  end
end
end
