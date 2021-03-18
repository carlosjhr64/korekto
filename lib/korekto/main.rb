module Korekto
class Main
  MD_STATEMENT_CODE_TITLE = %r{^(?<statement>.*)\s#(?<code>[A-Z](\d+(\.\w+)?(/[\w,.]+)?)?)( (?<title>\S.*?\S))?$}
  MD_FILENAME = %r{^< (?<filename>[/\w\-.]+)$}
  MD_KLASS_METHOD_DEFINITION = /^(?<klass>::[A-Z]\w+)#(?<method>\w+)(?<definition>[^=]*=.+)$/ # patch
  MD_RULE = /^[?] (?<rule>\S.*)$/
  MD_TYPE_PATTERN = %r{^! (?<type>\S+)\s*/(?<pattern>.*)/$}
  MD_TYPE_VARIABLES = /^! (?<type>\S+)\s*\{(?<variables>\S+( \S+)*)\}$/
  MD_KEY_VALUE = /^! (?<key>\w+):\s*'(?<value>.*)'$/

  M_FENCE = /^```\s*$/
  M_COMMENT_LINE = /^\s*#/

  BACKUPS = {}

  def initialize(filename='-', statements: Statements.new, imports: [])
    @filename,@statements,@imports = filename,statements,imports
    @imports.push @filename.freeze
    @line,@active = nil,false
    @section = File.basename(@filename,'.*')
    @m_fence_korekto = /^```korekto$/
  end

  def type_pattern(type, pattern)
    t2p = @statements.symbols.t2p
    raise Error, "type #{type} in use" if t2p.has_key? type
    t2p[type] = pattern
  end

  def type_variables(type, variables)
    v2t,t2p = @statements.symbols.v2t,@statements.symbols.t2p
    pattern = t2p[type]
    raise Error, "type #{type} not defined" unless pattern
    variables.each do |variable|
      raise Error, "variable #{variable} in use" if v2t.has_key? variable
      v2t[variable] = type
    end
  end

  def active?
    case @line
    when @m_fence_korekto
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

  def key_value(key, value)
    case key
    when 'scanner'
      @statements.symbols.set_scanner value
    when 'fence'
      @m_fence_korekto = Regexp.new "^```#{value}$"
    when 'section'
      @section = value
    when 'save'
      BACKUPS[value] = Marshal.dump(@statements)
    when 'restore'
      if backup = BACKUPS[value]
        @statements = Marshal.load(backup)
      else
        raise Error, "nothing saved as '#{value}'"
      end
    else
      raise Error, "key '#{key}' not implemented"
    end
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
    when MD_KEY_VALUE
      key_value($~[:key], $~[:value])
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
                                       @section,
                                       statement_number)
          puts "#{@filename}:#{line_number}:#{code}:#{title}"
        else
          raise Error, 'unrecognized korekto line'
        end
      rescue Error
        puts "#{@filename}:#{line_number}:!:#{$!.message}"
        exit 65
      rescue Exception
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
