module Korekto
class Main
  # rubocop: disable Layout/LineLength
  MD_STATEMENT_CODE_TITLE = %r{^(?<statement>.*)\s#(?<code>[A-Z](\d+(\.\w+)?(/[\w,.]+)?)?)(\s+(?<title>[^#]+))?$}
  MD_FILENAME = %r{^< (?<filename>[/\w\-.]+)$}
  MD_KLASS_METHOD_DEFINITION = /^(?<klass>::[A-Z]\w+)#(?<method>\w+)(?<definition>[^=]*=.+)$/ # patch
  MD_RULE = /^[?] (?<rule>\S.*)$/
  MD_TYPE_PATTERN = %r{^! (?<type>\S+)\s+/(?<pattern>.*)/$}
  MD_TYPE_VARIABLES = /^! (?<type>\S+)\s+\{(?<variables>\S+( \S+)*)\}$/
  MD_KEY_VALUE = /^! (?<key>\w+):\s+'(?<value>.*)'$/
  MD_FUNCTION = /^! (?<function>\w+)!(?<arguments>.*)$/
  # rubocop: enable Layout/LineLength

  M_FENCE = /^```\s*$/
  M_COMMENT_LINE = /^\s*#/

  BACKUPS = {}

  def initialize(filename='-', statements: Statements.new, imports: [])
    @filename,@statements,@imports = filename,statements,imports
    @imports.push @filename.freeze
    @line,@active = nil,false
    @section = File.basename(@filename,'.*')
    @m_fence_korekto = /^```korekto$/ # default fence
  end

  def t2p_gsub(target, replacement)
    t2p = @statements.symbols.t2p
    t2p.each_key{t2p[_1].gsub!(target, replacement)}
    @statements.patterns(&:set_regexp)
  end

  def type_pattern(type, pattern)
    t2p = @statements.symbols.t2p
    raise Error, "type #{type} in use" if t2p.key? type
    t2p[type] = pattern
  end

  def function(function, arguments)
    case function
    when 'stop'
      raise Error, 'stopped'
    when 'gsub'
      target, replacement, e = arguments.split
      raise Error, 'expected 2 arguments' unless e.nil? && replacement && target
      t2p_gsub(target, replacement)
    when 'delete'
      variable, e = arguments.split
      raise Error, 'expected 1 argument' unless e.nil? && variable
      @statements.symbols.v2t.delete variable
    when 'replace'
      oldvar, newvar, e = arguments.split
      raise Error, 'expected 2 arguments' unless e.nil? && newvar && oldvar
      v2t = @statements.symbols.v2t
      v2t[newvar] = v2t.delete(oldvar) or raise "#{oldvar} not a key"
    else
      raise Error, "unrecognized function: #{function}"
    end
  end

  def type_variables(type, variables)
    v2t,t2p = @statements.symbols.v2t,@statements.symbols.t2p
    pattern = t2p[type]
    raise Error, "type #{type} not defined" unless pattern
    variables.each do |variable|
      raise Error, "variable #{variable} in use" if v2t.key? variable
      v2t[variable] = type
    end
  end

  def patch(klass, method, definition)
    if Object.const_get(klass).method_defined?(method)
      raise Error, "overrides: #{klass}##{method}"
    end
    # rubocop: disable Security/Eval
    # rubocop: disable Style/DocumentDynamicEvalDefinition
    # rubocop: disable Style/EvalWithLocation
    eval <<~EVAL
      class #{klass}
        def #{method}#{definition}
      end
    EVAL
    # rubocop: enable Style/EvalWithLocation
    # rubocop: enable Style/DocumentDynamicEvalDefinition
    # rubocop: enable Security/Eval
  end

  def preprocess?
    case @line
    when MD_FILENAME
      filename = $~[:filename].strip
      unless @imports.include? filename
        tmp = @statements.heap.to_a.slice!(0..-1)
        Main.new(filename, statements:@statements, imports:@imports).run
        @statements.heap.to_a.replace(tmp)
      end
    when MD_KLASS_METHOD_DEFINITION
      if @filename=='-' && !Korekto.patch?
        # We'll trust files, but not stdin.
        raise Error, 'monkey patching not allowed on stdin'
      end
      patch($~[:klass],$~[:method],$~[:definition])
    when MD_RULE
      @statements.syntax.push $~[:rule].strip
    when MD_TYPE_PATTERN
      type_pattern($~[:type], $~[:pattern])
    when MD_TYPE_VARIABLES
      type_variables($~[:type], $~[:variables].split)
    when MD_KEY_VALUE
      key_value($~[:key], $~[:value])
    when MD_FUNCTION
      function($~[:function], $~[:arguments])
    else
      return false
    end
    true
  end

  def key_value(key, value)
    case key
    when 'scanner'
      @statements.symbols.set_scanner value
    when 'fence'
      @m_fence_korekto = Regexp.new "^```#{value}$" # user defined fence
    when 'section'
      @section = value
    when 'save'
      BACKUPS[value] = Marshal.dump(@statements)
    when 'restore'
      if (backup = BACKUPS[value])
        @statements = Marshal.load(backup)
      else
        raise Error, "nothing saved as '#{value}'"
      end
    else
      raise Error, "key '#{key}' not implemented"
    end
  end

  def parse(lines)
    statement_number = line_number = 0
    while (@line = lines.shift)
      begin
        line_number += 1
        next unless active?
        next if preprocess?
        if (md = MD_STATEMENT_CODE_TITLE.match @line)
          code,title = @statements.add(md[:statement].strip,
                                       md[:code],
                                       md[:title],
                                       @section
                                        # Block executes if statement is new.
                                        # Method recieves the return value.
                                      ){ statement_number += 1 }
          if Korekto.scrape?
            print @statements.last
            print "\t##{code}"
            print " #{title}" unless title.nil? || title.empty?
            puts
          elsif Korekto.trace? ||
                (@filename=='-' && !(md[:code]==code && md[:title]==title))
            puts "#{@filename}:#{line_number}:#{code}:#{title}"
          end
        else
          raise Error, 'unrecognized korekto line'
        end
      rescue Error
        puts "#{@filename}:#{line_number}:!:#{$!.message}"
        exit 65
      rescue StandardError
        puts "#{@filename}:#{line_number}:?:#{$!.message}"
        warn $!.backtrace
        exit 1
      end
    end
  end

  def run
    parse @filename=='-' ? $stdin.readlines(chomp: true) :
                           File.readlines(@filename, chomp: true)
  end

  # Is the current line a non-comment Korekto line?
  def active?
    case @line
    when @m_fence_korekto
      raise Error, 'unexpected fence' if @active
      @active = true
      false
    when M_FENCE
      @active = false
    else
      @active && !M_COMMENT_LINE.match?(@line)
    end
  end
end
end
