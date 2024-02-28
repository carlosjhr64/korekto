module Korekto
class Syntax
  def initialize = @a=[]
  def to_a = @a

  using Refinements

  def push(s)
    # ensure it'll eval on string and returns boolean
    b = ''.instance_eval(s)
    # rubocop: disable Style/DoubleNegation
    raise Error, 'syntax rule must eval boolean' unless b==!!b
    # rubocop: enable Style/DoubleNegation
    @a.push(s)
  rescue StandardError
    raise if $!.is_a? Error
    raise Error, "#{$!.class}: #{s}"
  end

  def check(statement, c)
    return if statement[0]=='/' && statement[-1]=='/' &&
              %w[A L M E I].include?(c)
    @a.each do |rule|
      next if statement.instance_eval(rule)
      raise Error, "syntax: #{rule}"
    rescue StandardError
      raise if $!.is_a? Error
      raise Error, "#{$!.class}: #{rule}"
    end
  end
end
end
