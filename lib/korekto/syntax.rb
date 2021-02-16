module Korekto
class Syntax
  def initialize
    @a = []
  end

  def push(s)
    # ensure it'll eval on string and returns boolean
    b = ''.instance_eval(s)
    raise Error, 'syntax rule must eval boolean' unless b==!!b
    @a.push(s)
  rescue
    raise Error, "#{$!.class}: #{s}"
  end

  def each
    @a.each{|s| yield s}
  end
end
end
