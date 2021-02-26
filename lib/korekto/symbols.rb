module Korekto
class Symbols
  attr_reader :t2p, :v2t
  def initialize
    @h   = {}
    @t2p = {}
    @v2t = {}
    @scanner = /:\w+|./
  end

  def set_scanner(value)
    @scanner = Regexp.new(value)
  end

  def undefined(statement)
    undefined = []
    if statement.pattern?
      unless statement.literal_regexp?
        statement.scan(@scanner){|w| undefined.push(w) unless @v2t.include?(w) or @h.include?(w)}
      end
    else
      statement.scan(@scanner){|w| undefined.push(w) unless @h.include?(w)}
    end
    return undefined.uniq
  end

  def define!(statement)
    if statement.pattern?
      unless statement.literal_regexp?
        statement.scan(@scanner){|w| @h[w]=nil unless @v2t.include?(w) or @h.include?(w)}
      end
    else
      statement.scan(@scanner){|w| @h[w]=nil unless @h.include?(w)}
    end
  end

  def s2r(statement)
    if statement[0]=='/' and statement[-1]=='/'
      Regexp.new(statement[1..-2])
    else
      pattern,count,seen = '^',0,{}
      Regexp.quote(statement).scan(@scanner) do |v|
        if type = @v2t[v]
          if type==':nl'
            pattern << @t2p[type]
          else
            if n=seen[v]
              pattern << '\\'+n
            else
              count += 1
              seen[v]=count.to_s
              pattern << '('+@t2p[type]+')'
            end
          end
        else
          pattern << v
        end
      end
      raise Error, 'pattern with no captures' if count < 1
      pattern << '$'
      Regexp.new(pattern)
    end
  end
end
end
