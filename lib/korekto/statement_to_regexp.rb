module Korekto
class StatementToRegexp
  def initialize
    @h = {}
  end

  def to_h
    @h
  end

  def s2r(s)
    case s
    when %r{^/(.*)/$}
      Regexp.new($1) # memoize
    else
      raise "unrecognized pattern case: #{s.inspect}"
    end
  end

  def [](s)
    @h[s] ||= s2r(s)
  end
end
end
