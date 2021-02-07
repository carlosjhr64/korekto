class Korekto
  VERSION = '0.0.210207'
  SYNTAX = []
  STATEMENTS = []

  def initialize(filename=nil)
    @filename = filename
    @active = false
    @line_number = 0
  end

  def active?
    case @line
    when /^```korekto\s*$/
      raise 'unexpected fence' if @active
      @active = true
      false
    when /^```\s*$/
      @active = false
      false
    else
      @active
    end
  end

  def statement?
    case @line
    when /^<\s*(.*)$/
      filename = $1.strip
      Korekto.new(filename).run
    when /^\s*#/ # comment
      false
    when /^!(.*)$/ # rule
      SYNTAX.push $1.strip
      false
    when /^(::[A-Z]\w+)#(.*)$/
      eval <<~EVAL
        class #{$1}
          def #{$2}
        end
      EVAL
      false
    else
      true
    end
  end

  def valid?
    valid = true
    SYNTAX.each do |rule|
      raise 'syntax' unless @line.instance_eval(rule)
    rescue
      msg = $!.message
      puts "#{@filename || '-'}:#{@line_number}:0:!:#{msg}:#{rule}"
      if msg=='syntax'
        valid = false
        break
      else
        SYNTAX.delete rule # bad rule
      end
    end
    return valid
  end

  def accepted?
    if STATEMENTS.include? @line
      puts "#{@filename || '-'}:#{@line_number}:0::restatement:"
      STATEMENTS.delete @line
      return true
    end
    puts "#{@filename || '-'}:#{@line_number}:0::pass:"
    return true
  end

  def parse(lines)
    while @line = lines.shift
      @line_number += 1
      next unless active?
      next unless statement?
      @line.sub!(/\s*#.*$/,'') # strip out the comment
      next unless valid?
      STATEMENTS.push @line if accepted?
    end
  end

  def run
    if @filename
      parse IO.readlines(@filename, chomp: true)
    else
      parse $stdin.readlines(chomp: true)
    end
  end
end
# Requires:
# `ruby`
