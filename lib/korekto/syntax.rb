module Korekto
class Syntax
  def initialize
    @a = []
  end

  def to_a
    @a
  end

  def push(s)
    @a.push(s)
  end

  def each
    @a.each{|s| yield s}
  end
end
end
