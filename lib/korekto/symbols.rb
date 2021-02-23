module Korekto
class Symbols
  def initialize
    @h = {}
    @scanner = /:\w+|./
  end

  def undefined(statement)
    undefined = []
    statement.scan(@scanner) do |w|
      undefined.push w unless @h.include? w
    end
    return undefined.uniq
  end

  def define!(statement, skip={})
    statement.scan(@scanner){|w| @h[w]=nil unless skip.include? w}
  end
end
end
