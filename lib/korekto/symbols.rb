module Korekto
class Symbols
  def self.each(statement)
    chars = statement.chars
    while w = chars.shift
      if w==':'
        while c = chars.shift
          break(chars.unshift c) if c=~/\W/
          w << c
        end
      end
      yield w
    end
  end

  def initialize
    @a = Hash.new
  end

  def undefined(statement)
    undefined = []
    Symbols.each(statement) do |w|
      undefined.push w unless @a.include? w
    end
    return undefined
  end

  def define!(statement, skip={})
    Symbols.each(statement){|w| @a[w]=nil unless skip.include? w}
  end
end
end
