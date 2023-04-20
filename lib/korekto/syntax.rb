module Korekto
class Syntax
  def initialize = @a=[]
  def each(&blk) = @a.each{|s| blk[s]}

  def push(s)
    # ensure it'll eval on string and returns boolean
    b = ''.instance_eval(s)
    # rubocop: disable Style/DoubleNegation
    raise Error, 'syntax rule must eval boolean' unless b==!!b
    # rubocop: enable Style/DoubleNegation
    @a.push(s)
  rescue
    raise Error, "#{$!.class}: #{s}"
  end
end
end
