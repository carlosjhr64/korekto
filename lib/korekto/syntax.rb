module Korekto
class Syntax
  def initialize
    @a = []
  end

  def push(s)
    # ensure it'll eval on string and returns boolean
    b = ''.instance_eval(s)
    raise 'syntax rule must eval boolean' unless b==!!b
    @a.push(s)
  end

  def each
    @a.each{|s| yield s}
  end
end
end
