# frozen_string_literal: true

module Korekto
  # Represents a single Korekto statement.
  # A Statement is created from a raw line of text together with metadata
  # (code, title, section, number, and proof context). It determines its
  # logical role (postulate, definition, tautology, set, result, etc.)
  # by matching against previously registered pattern statements
  # (axioms, let-rules, map-rules, inference-rules, …) and by analysing
  # which symbols are undefined in the current context.
  # The class is immutable after initialization
  # :reek:MissingSafeMethod
  # :reek:UncommunicativeVariableName
  class Statement
    include StatementHandlers
    include ContextSearch

    using Refinements

    def initialize(context, *)
      @context = context
      @symbols = context.symbols
      @s = StatementStruct.new(*)
      init!
      set_acceptance_code
      finalize!
    end

    def struct = @s

    private

    def init!
      # These may be reset later:
      @s.title ||= ''
      @s.type = @s.code[0]
      @s[:pattern?] = false
      @s[:literal_regexp?] = false
    end

    def finalize!
      @s[:defines_symbols?] = !@s.literal_regexp? &&
                              'AIEMLDXS'.include?(@s.type)
      @s.each(&:freeze)
      @s.freeze
    end

    # Sets the final acceptance code, title, and key for the statement by
    # dispatching to the appropriate type handler (tautology, definition, etc.)
    # based on the initial code letter. Raises if type unsupported.
    def set_acceptance_code(type = @s.type)
      handler = TYPE_HANDLERS[type]
      raise(Error, "type '#{type}' not implemented") unless handler

      send(handler)
    end

    def set_type!(type) = (@s.type = @s.code[0] = type)

    def set_regexp!
      @s[:pattern?] = true
      statement = @s.statement
      @s.regexp = if (statement[0] == '/') && (statement[-1] == '/')
                    @s[:literal_regexp?] = true
                    Regexp.new statement[1..-2]
                  else
                    @symbols.statement_to_regexp(statement)
                  end
    end

    # nlc: "\n" count
    def verify_newlines_count!(nlc)
      return if nlc == @s.regexp.inspect.gsub('\\\\', '').scan('\\n').length

      raise Error, "expected #{nlc} newlines"
    end

    def undefined_symbols_get
      return nil if @s.literal_regexp?

      @symbols.undefined(@s)
    end

    def handwaves_check! = @context.handwaves.check!(@s)

    # :reek:DuplicateMethodCall { allow_calls: [ '@s.section' ] }
    def set_code!(support = nil)
      code = "#{@s.type}#{@s.statement_number}"
      code << ".#{@s.section}" unless @s.section == '-'
      @s.key = code.to_sym
      code << "/#{support}" if support
      @s.code = code
    end

    def set_title!(title = @s.title, undefined: nil)
      title = title.split(':', 2).first
      title << ": #{undefined.join(' ')}" if undefined&.size&.positive?
      @s.title = title
    end

    def pattern_type_support(follows)
      support(*follows) if @s.regexp.match?(follows.map(&:to_s).join("\n"))
    end

    def support(*statements)
      statements.map { it.code.split('/', 2).first }.join(',')
    end

    def expected_instantiations!(title = @s.title, instantiations: nil)
      empty = (size = (undefined = @symbols.undefined(@s)).size).zero?
      if instantiations ||= title.match_to_i(/[1-9]\d*/)
        unless instantiations == size
          raise Error,
                "expected #{instantiations} undefined: #{undefined.join(' ')}"
        end
      elsif empty
        raise Error, 'nothing was undefined'
      end
      empty ? nil : undefined
    end
  end
end
