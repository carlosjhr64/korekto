module Korekto
class Main
  MD_STATEMENT_CODE_TITLE = %r{^(?<statement>.*)\s#(?<code>[A-Z](\d+(/[A-Z]\d+\S*)?)?)( (?<title>[A-Z][\w\s]*\w))?$}
  MD_FILENAME = %r{^< (?<filename>[/\w\-.]+)$}
  MD_KLASS_METHOD_DEFINITION = /^(?<klass>::[A-Z]\w+)#(?<method>\w+)(?<definition>[^=]*=.+)$/ # patch
  MD_RULE = /^[?] (?<rule>\S.*)$/
  MD_TYPE_PATTERN = %r{^! (?<type>\p{L}|:\w+)\s*/(?<pattern>.*)/$}
  MD_TYPE_VARIABLES = /^! (?<type>\p{L}|:\w+)\s*\{(?<variables>\p{Graph}( \p{Graph})*)\}$/

  M_FENCE_KOREKTO = /^```korekto$/
  M_FENCE = /^```\s*$/
  M_COMMENT_LINE = /^\s*#/

  def initialize(filename='-', statements: Statements.new, imports: [])
    @filename,@statements,@imports = filename,statements,imports
    @imports.push @filename
    @line,@active = nil,false
  end

  def type_pattern(type, pattern)
    t2p = @statements.s2r.t2p
    raise Error, "type #{type} in use" if t2p.has_key? type
    t2p[type] = pattern
  end

  def type_variables(type, variables)
    v2t,t2p = @statements.s2r.v2t,@statements.s2r.t2p
    pattern = t2p[type]
    raise Error, "type #{type} not defined" unless pattern
    variables.each do |variable|
      raise Error, "variable #{variable} in use" if v2t.has_key? variable
      v2t[variable] = type
    end
  end

  def active?
    case @line
    when M_FENCE_KOREKTO
      raise Error, 'unexpected fence' if @active
      @active = true
      false
    when M_FENCE
      @active = false
      false
    else
      @active and not M_COMMENT_LINE.match?(@line)
    end
  end

  def patch(klass, method, definition)
    raise Error, "overrides: #{klass}##{method}" if eval(klass).method_defined? method
    eval <<~EVAL
      class #{klass}
        def #{method}#{definition}
      end
    EVAL
  end

  def preprocess?
    case @line
    when MD_FILENAME
      filename = $~[:filename].strip
      unless @imports.include? filename
        Main.new(filename, statements:@statements, imports:@imports).run
      end
    when MD_KLASS_METHOD_DEFINITION
      patch($~[:klass],$~[:method],$~[:definition])
    when MD_RULE
      @statements.syntax.push $~[:rule].strip
    when MD_TYPE_PATTERN
      type_pattern($~[:type], $~[:pattern])
    when MD_TYPE_VARIABLES
      type_variables($~[:type], $~[:variables].split)
    else
      return false
    end
    true
  end

  def parse(lines)
    statement_number = line_number = 0
    while @line = lines.shift
      begin
        line_number += 1
        next unless active?
        next if preprocess?
        if md = MD_STATEMENT_CODE_TITLE.match(@line)
          statement_number += 1
          code,title = @statements.add(md[:statement].strip,
                                       md[:code],
                                       md[:title],
                                       @filename,
                                       statement_number)
          puts "#{@filename}:#{line_number}:#{code}:#{title}"
        else
          raise Error, 'unrecognized korekto line'
        end
      rescue Error
        puts "#{@filename}:#{line_number}:!:#{$!.message}"
        exit 65
      rescue
        puts "#{@filename}:#{line_number}:?:#{$!.message}"
        $stderr.puts $!.backtrace
        exit 1
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
