# frozen_string_literal: true

module Korekto
  # Main processor for Korekto input files.
  # Parses markdown-style Korekto documents, handling statements,
  # type definitions, imports, syntax rules, and fenced code blocks.
  # Supports preprocessing directives for configuration and control.
  # rubocop: disable Metrics
  class Main
    def initialize(filename = '-', statements: Statements.new, imports: [])
      @filename = filename
      @statements = statements
      @imports = imports
      @filename.freeze
      @section = File.basename(@filename, '.*')
      @imports.push @section
      @fence_open = /^```korekto$/ # default fence
      @line = nil
      @active = false
      @backups = {}
    end

    def run
      parse @filename == '-' ? $stdin.readlines(chomp: true) : File.readlines(
        @filename, chomp: true
      )
    end

    # rubocop: disable Layout/LineLength, Lint/MixedRegexpCaptureTypes
    MD_STATEMENT_CODE_TITLE = %r{^(?<statement>.*)\s#(?<code>[A-Z](\d+(\.\w+)?(/[\w,.]+)?)?)(\s+(?<title>[^#]+))?$}
    MD_IMPORT = %r{^< (?<filename>[/\w\-.]+)$}
    MD_SYNTAX = /^[?] (?<syntax>\S.*)$/
    MD_TYPE_PATTERN = %r{^! (?<type>\S+)\s+/(?<pattern>.*)/$}
    MD_TYPE_VARIABLES = /^! (?<type>\S+)\s+\{(?<variables>\S+( \S+)*)\}$/
    MD_KEY_VALUE = /^! (?<key>\w+):\s+'(?<value>.*)'$/
    MD_FUNCTION = /^! (?<function>\w+)!(?<arguments>.*)$/
    MD_HANDWAVE = /^~ (?<handwave>.*)$/
    # rubocop: enable Layout/LineLength, Lint/MixedRegexpCaptureTypes

    M_FENCE_CLOSE = /^```\s*$/
    M_COMMENT_LINE = /^\s*#/

    private_constant :MD_STATEMENT_CODE_TITLE, :MD_IMPORT, :MD_SYNTAX,
                     :MD_TYPE_PATTERN, :MD_TYPE_VARIABLES, :MD_KEY_VALUE,
                     :MD_FUNCTION, :MD_HANDWAVE, :M_FENCE_CLOSE,
                     :M_COMMENT_LINE

    private

    def type_to_pattern_gsub(target, replacement)
      type_to_pattern = @statements.symbols.type_to_pattern
      type_to_pattern.each_key do |type|
        type_to_pattern[type].gsub!(target, replacement)
      end
      @statements.patterns(&:set_regexp)
    end

    # Defines a regex pattern for a type; raises if type already exists.
    #     ! Variable /[a-z]/
    def type_pattern(type, pattern)
      type_to_pattern = @statements.symbols.type_to_pattern
      raise Error, "type #{type} in use" if type_to_pattern.key? type

      type_to_pattern[type] = pattern
    end

    # Executes built-in functions (stop, gsub, delete, replace).
    # Stop the parsing of the file:
    #     ! stop!
    # Replace a variable_to_type's key with another.
    # Useful to temporally disabling it:
    #     ! replace! x TMP
    # Delete a variable_to_type's key:
    #     ! delete! x
    # Globally change patterns in the type_to_pattern hash:
    #     ! gsub: x y
    # These features should be fully covered in the tutorial.
    def function(function, arguments)
      case function
      when 'stop'
        raise Error, 'stopped'
      when 'gsub'
        target, replacement, e = arguments.split
        unless e.nil? && replacement && target
          raise Error,
                'expected 2 arguments'
        end

        type_to_pattern_gsub(target, replacement)
      when 'delete'
        variable, e = arguments.split
        raise Error, 'expected 1 argument' unless e.nil? && variable

        @statements.symbols.variable_to_type.delete variable
      when 'replace'
        oldvar, newvar, e = arguments.split
        raise Error, 'expected 2 arguments' unless e.nil? && newvar && oldvar

        variable_to_type = @statements.symbols.variable_to_type
        variable_to_type[newvar] =
          variable_to_type.delete(oldvar) or raise "#{oldvar} not a key"
      else
        raise Error, "unrecognized function: #{function}"
      end
    end

    # Assigns variables to a type; validates type exists and variables are free.
    #     ! Variable {a b c}
    # These variables are translated into their patterns
    # when found in pattern statements.
    def type_variables(type, variables)
      variable_to_type = @statements.symbols.variable_to_type
      type_to_pattern = @statements.symbols.type_to_pattern
      pattern = type_to_pattern[type]
      raise Error, "type #{type} not defined" unless pattern

      variables.each do |variable|
        if variable_to_type.key? variable
          raise Error,
                "variable #{variable} in use"
        end

        variable_to_type[variable] = type
      end
    end

    # Processes non-statement directives
    #     < imports
    #     ? syntax
    #     ! types, functions
    #     ~ handwaves
    # Returns true if line is handled, false otherwise.
    def preprocess?
      case @line
      when MD_IMPORT
        filename = $LAST_MATCH_INFO[:filename].strip
        bn = File.basename(filename, '.*')
        xt = File.extname(filename)
        case xt
        when '.rb'
          begin
            raise Error, "already been loaded: #{bn}" unless require filename
          rescue LoadError
            raise Error, $ERROR_INFO.message
          end
        else
          raise Error, "duplicate import: #{bn}" if @imports.include? bn

          tmp = @statements.heap.to_a.slice!(0..-1)
          Main.new(filename, statements: @statements, imports: @imports).run
          @statements.heap.to_a.replace(tmp)
        end
      when MD_SYNTAX
        @statements.syntax.push $LAST_MATCH_INFO[:syntax].strip
      when MD_TYPE_PATTERN
        type_pattern($LAST_MATCH_INFO[:type], $LAST_MATCH_INFO[:pattern])
      when MD_TYPE_VARIABLES
        type_variables($LAST_MATCH_INFO[:type],
                       $LAST_MATCH_INFO[:variables].split)
      when MD_KEY_VALUE
        key_value($LAST_MATCH_INFO[:key], $LAST_MATCH_INFO[:value])
      when MD_FUNCTION
        function($LAST_MATCH_INFO[:function], $LAST_MATCH_INFO[:arguments])
      when MD_HANDWAVE
        @statements.handwaves.push $LAST_MATCH_INFO[:handwave]
      else
        return false
      end
      true
    end

    # Handles key-value configuration directives.
    # Examples:
    #     ! scanner: ':\w+|'
    #     ! fence: 'ruby'
    #     ! save: 'backup1'
    #     ! restore: 'backup1'
    # Marshal is being used internally(trusted) to backup State.
    def key_value(key, value)
      case key
      when 'scanner'
        @statements.symbols.scanner = value
      when 'fence'
        @fence_open = Regexp.new "^```#{value}$" # user defined fence
      when 'section'
        raise Error, "duplicate section: #{value}" if @imports.include? value

        @imports.push value
        @section = value
      when 'save'
        @backups[value] = Marshal.dump(@statements)
      when 'restore'
        if (backup = @backups[value])
          # rubocop: disable Security/MarshalLoad
          @statements = Marshal.load(backup)
          # rubocop: enable Security/MarshalLoad
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
            # Block executes if statement is new.
            # Method receives the return value.
            code, title = @statements.add(md[:statement].strip,
                                          md[:code],
                                          md[:title],
                                          @section) { statement_number += 1 }
            if Korekto.scrape?
              print @statements.last
              print "\t##{code}"
              print " #{title}" unless title.nil? || title.empty?
              puts
            elsif Korekto.trace? || (@filename == '-' &&
                                    !(md[:code] == code &&
                                    md[:title] == title))
              puts "#{@filename}:#{line_number}:#{code}:#{title}"
            end
          else
            raise Error, 'unrecognized korekto line'
          end
        rescue Error
          puts "#{@filename}:#{line_number}:!:#{$ERROR_INFO.message}"
          exit 65
        rescue StandardError
          puts "#{@filename}:#{line_number}:?:#{$ERROR_INFO.message}"
          warn $ERROR_INFO.backtrace
          exit 1
        end
      end
    end

    # Is the current line a non-comment Korekto line?
    # Returns true if current line is inside active Korekto fence and
    # not a comment.
    def active?
      case @line
      when @fence_open
        raise Error, 'unexpected fence' if @active

        @active = true
        false
      when M_FENCE_CLOSE
        @active = false
      else
        @active && !M_COMMENT_LINE.match?(@line)
      end
    end
  end
  # rubocop: enable Metrics
end
