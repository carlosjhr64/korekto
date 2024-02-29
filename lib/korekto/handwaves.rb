module Korekto
class Handwaves
  def initialize(context)
    @context   = context
    @handwaves = []
    @captures  = []
  end

  def to_a = @handwaves

  def push(s)
    raise Error, 'duplicate handwave' if @handwaves.include?(s)
    @handwaves.push(s)
  end

  def gsub!(pattern)
    # Reverse allows to first gsub captures with index > 9
    @captures.each_with_index.reverse_each do |x, i|
      pattern.gsub!("$#{i+1}", x)
    end
    pattern
  end

  def ex(command)
    @captures.clear
    consequent = @antecedent.dup
    command.split('|').each do |step|
      case step
      when %r{^([mM])/(.*)/(t)?$}
        command,pattern,t,n = $1,$2,$3,0
        pattern,n = @context.symbols.s2p(pattern, quote:false) if t
        string = command=='M' ? @antecedent : @statement
        md = Regexp.new(gsub! pattern).match(string)
        break unless md
        1.upto(n).each{@captures.push(md[_1])}
      when %r{^g/(.*)/(t)?$}
        pattern,t,n = $1,$2,0
        pattern,n = @context.symbols.s2p($1, quote:false) if t
        rgx = Regexp.new(gsub! pattern)
        md = nil
        break unless @heap.any?{(md=rgx.match _1)}
        1.upto(n).each{@captures.push(md[_1])}
      when %r{^s/(.*?)/(.*)/(g)?$}
        pattern,substitute,g = $1,$2,$3
        rgx = Regexp.new(gsub! pattern)
        gsub!(substitute)
        g ? consequent.gsub!(rgx,substitute) : consequent.sub!(rgx,substitute)
      else
        raise Error, "unrecognized handwave step: #{step}"
      end
    end
    @statement == consequent
  end

  def check(statement)
    @heap = @context.heap.to_a
    @statement = statement
    @antecedent = @heap.first.to_s
    raise Error, 'no handwaves found' unless @handwaves.any? do |handwave|
      case handwave
      when /^[:]/
        ex(handwave[1..])
      else
        raise "unrecognized: #{handwave}"
      end
    end
  end
end
end
