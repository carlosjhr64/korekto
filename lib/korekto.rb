class Korekto
  class KorektoError < Exception
  end

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
    when /^<\s*(.*)$/ # import
      filename = $1.strip
      Korekto.new(filename).run
      false
    when /^\s*#/ # comment
      false
    when /^!(.*)$/ # rule
      SYNTAX.push $1.strip
      false
    when /^(::[A-Z]\w+)#(\w+)(.*)$/ # patch
      klass,method,definition = $1,$2,$3
      raise "overides: #{klass}##{method}" if eval(klass).method_defined? method
      eval <<~EVAL
        class #{klass}
          def #{method}#{definition}
        end
      EVAL
      false
    else
      true
    end
  end

  def syntax_checker
    SYNTAX.each do |rule|
      raise KorektoError, "syntax: #{rule}" unless @line.instance_eval(rule)
    rescue
      raise "#{$!.class}: #{rule}"
    end
  end

  def get_acceptance_code
    return 'restatement' if STATEMENTS.include? @line
    return 'pass'
  end

  def parse(lines)
    while @line = lines.shift
      begin
        @line_number += 1
        next unless active?
        next unless statement?
        @line.sub!(/#.*$/,'') # strip out the comment
        @line.strip!
        syntax_checker
        code = get_acceptance_code
        STATEMENTS.delete @line
        STATEMENTS.push @line
        puts "#{@filename}:#{@line_number}:0::#{code}"
      rescue KorektoError
        puts "#{@filename}:#{@line_number}:0:!:#{$!.message}"
      rescue
        puts "#{@filename}:#{@line_number}:0:?:#{$!.message}"
        exit
      end
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
