module Korekto
class Symbols
  def initialize
    @a = []
  end

  def to_a
    @a
  end

  def insert(w)
    if index = @a.bsearch_index{|c| c >= w}
      @a.insert(index, w)  unless w == @a.fetch(index)
    else
      @a.push w
    end
  end

  def defined?(w)
    @a.bsearch{|c| w <=> c} ? true : false
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
      undefined.push w unless @a.bsearch{|c| w <=> c}
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
      insert(w)
    end
  end
end
end
# Requires:
# `ruby`
