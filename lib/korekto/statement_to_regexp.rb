module Korekto
class S2R
  def self.[](statement)
    case statement
    when %r{^/(.*)/$}
      Regexp.new($1)
    else
      raise "unrecognized pattern case: #{statement.inspect}"
    end
  end
end
end
