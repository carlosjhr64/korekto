module Korekto
class Syntax
  def initialize
    @a = []
  end

  def push(s)
    ''.instance_eval(s) # ensure it'll eval on string
    @a.push(s)
  end

  def each
    @a.each{|s| yield s}
  end
end
end
