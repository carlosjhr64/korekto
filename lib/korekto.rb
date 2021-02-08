class Korekto
  VERSION = '0.0.210208'
  SYNTAX = []
  STATEMENTS = []

  def initialize(filename='-')
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
      puts "#{@filename}:#{@line_number}:0:!:#{msg}:#{rule}"
      valid = false
      SYNTAX.delete(rule) unless msg=='syntax' # bad rule
      break
    end
    return valid
  end

  def accepted?
    if STATEMENTS.include? @line
      puts "#{@filename}:#{@line_number}:0::restatement:"
      return true
    end
    puts "#{@filename}:#{@line_number}:0::pass:"
    return true
  end

  def parse(lines)
    while @line = lines.shift
      @line_number += 1
      next unless active?
      next unless statement?
      @line.sub!(/\s*#.*$/,'') # strip out the comment
      next unless valid?
      next unless accepted?
      STATEMENTS.delete @line
      STATEMENTS.push @line
    end
  end

  def run
    if @filename=='-'
      parse $stdin.readlines(chomp: true)
    else
      parse IO.readlines(@filename, chomp: true)
    end
  end
end
# Requires:
# `ruby`
