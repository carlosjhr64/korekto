module Korekto
class S2R
  attr_reader :t2p, :v2t
  def initialize
    @t2p = {}
    @v2t = {}
  end

  def [](statement)
    if statement[0]=='/' and statement[-1]=='/'
      Regexp.new(statement[1..-2])
    else
      pattern,count,seen = '^',0,{}
      Korekto::Symbols.each(Regexp.quote(statement)) do |v|
        if type = @v2t[v]
          if n=seen[v]
            pattern << '\\'+n
          else
            count += 1
            seen[v]=count.to_s
            pattern << '('+@t2p[type]+')'
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
