module Korekto
class Symbols
  def initialize
    @a = Hash.new
  end

  def undefined(statement)
    undefined,chars = [],statement.chars
    while w = chars.shift
      if w==':'
        while c = chars.shift
          break(chars.unshift c) if c=~/\W/
          w<<c
        end
      end
      undefined.push w unless @a.include? w
    end
    return undefined
  end

  def define!(statement)
    chars = statement.chars
    while w = chars.shift
      if w==':'
        while c = chars.shift
          break(chars.unshift c) if c=~/\W/
          w<<c
        end
      end
      @a[w]=nil
    end
  end
end
end
# Requires:
# `ruby`
