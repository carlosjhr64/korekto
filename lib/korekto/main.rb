module Korekto
class Main
  def initialize(filename='-')
    @filename = filename
    @line,@active = nil,false
  end

=begin
  # TODO:
  LOGIC = {}
  TYPE = {}
  PATTERN = {}


  # TODO:
  def pattern(name, pattern)
    raise "name #{name} in use" if PATTERN.has_key? name
    PATTERN[name] = Regexp.new(pattern)
  end

  # TODO:
  def types(name, variables)
    pattern = PATTERN[name]
    raise "name #{name} not defined" unless pattern
    variables.each do |variable|
      raise "variable #{variable} in use" if TYPE.has_key? variable
      raise "variable #{variable} in pattern #{name}: #{pattern.inspect}" if pattern.match? variable
      TYPE[variable] = name
    end
  end
=end

  def active?
    case @line
    when /^```korekto$/
      raise 'unexpected fence' if @active
      @active = true
      false
    when /^```\s*$/
      @active = false
      false
    else
      @active and not (/^\s*#/).match?(@line)
    end
  end

  def patch(klass, method, definition)
    raise "overides: #{klass}##{method}" if eval(klass).method_defined? method
    eval <<~EVAL
      class #{klass}
        def #{method}#{definition}
      end
    EVAL
  end

  SYNTAX = Syntax.new
  def preprocess?
    case @line
    when %r{^< (?<filename>[/\w\-.]+)$}
      Main.new($~[:filename].strip).run
    when /^(?<klass>::[A-Z]\w+)#(?<method>\w+)(?<definition>[^=]*=.+)$/ # patch
      patch($~[:klass],$~[:method],$~[:definition])
    when /^[?] (\w.*)$/
      SYNTAX.push $1.strip
=begin
    when %r{^! (\p{L}|:\w+)/(.*)/$}
      # TODO:
      pattern($1, $2)
    when /^! (\p{L}|:\w+){\p{L}( \p{L})*}$/
      # TODO:
      types($1, $2.split)
=end
    else
      return false
    end
    true
  end

  STATEMENTS = Statements.new
  FORMAT = %r{^(?<statement>.*)\s#(?<code>[A-Z](\d+(/[A-Z]\d+(,[A-Z]\d+)*)?)?)( (?<title>[A-Z][\w\s]*\w))?$}
  def parse(lines)
    line_number = 0
    while @line = lines.shift
      begin
        line_number += 1
        next unless active?
        next if preprocess?
        if md = FORMAT.match(@line)
          code,title = STATEMENTS.add(md[:statement].strip, md[:code], md[:title])
          puts "#{@filename}:#{line_number}:0:#{code}:#{title}"
        else
          raise 'unrecognized korekto line'
        end
      rescue Statement::Error
        puts "#{@filename}:#{line_number}:0:!:#{$!.message}"
      rescue
        puts "#{@filename}:#{line_number}:0:?:#{$!.message}"
        $stderr.puts $!.backtrace if $VERBOSE
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
end
