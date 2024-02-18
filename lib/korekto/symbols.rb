module Korekto
class Symbols
  attr_reader :t2p, :v2t

  def initialize
    @set   = Set.new # Set of Korekto symbols(strings)
    @v2t = {} # Variable to Type
    @t2p = {} # Type to Pattern
    @scanner = /:\w+|./ # Default scanner
  end

  # rubocop: disable Naming/AccessorMethodName
  def set_scanner(value) = @scanner=Regexp.new(value)
  # rubocop: enable Naming/AccessorMethodName

  def undefined(statement)
    undefined = Set.new
    if statement.pattern?
      unless statement.literal_regexp?
        statement.scan(@scanner) do |w|
          undefined<<w unless @v2t.include?(w) || @set.include?(w)
        end
      end
    else
      statement.scan(@scanner){|w| undefined<<w unless @set.include?(w)}
    end
    undefined
  end

  def define!(statement) = undefined(statement).each{|w| @set<<w}

  def s2p(statement)
    pattern,count,seen = '',0,{}
    # Build pattern from statement token by token, v.
    statement.scan(@scanner) do |v|
      if (n=seen[v])
        pattern << '\\'+n
      elsif (type = @v2t[v])
        regex = @t2p[type]
        if type[0]=='.'
          # No capture patterns start with '.'
          pattern << regex
        else
          count += 1
          seen[v]=count.to_s
          pattern << '('+regex+')'
        end
      else
        # Escape Regexp specials
        v = Regexp.quote v
        # To avoid collisions with back-references,
        # isolate digit in square brackets:
        '0123456789'.include?(_=v[0]) and v[0]='['+_+']'
        pattern << v
      end
    end
    [pattern, count]
  end

  def s2r(statement)
    return Regexp.new statement[1..-2] if statement[0]=='/' &&
                                          statement[-1]=='/'
    pattern, count = s2p(statement)
    raise Error, 'pattern with no captures' if count < 1
    Regexp.new('\A'+pattern+'\Z')
  end
end
end
