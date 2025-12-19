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
  # :reek:UncommunicativeVariableName { accept: [ s0, s1, s2 ] }
  # :reek:TooManyInstanceVariables
  # :reek:TooManyMethods
  # rubocop: disable Metrics/ClassLength
  class Statement
    include StatementHandlers
    using Refinements

    attr_reader :code, :title, :regexp, :section, :statement_number, :key

    def initialize(*args)
      @statement, @code, @title, @section, @statement_number, @context = args
      @title, = @title.split(':', 2) if @title
      @regexp = @key = nil
      set_acceptance_code
      [@statement, @section, @statement_number,
       @code,      @title,   @regexp].each(&:freeze)
    end

    def type              = @code[0]
    def to_s              = @statement
    def to_str            = @statement
    def match?(statement) = @regexp.match?(statement)
    def scan(regex, &)    = @statement.scan(regex, &)
    # :reek:NilCheck
    def pattern?          = !@regexp.nil?

    def set_regexp
      @regexp = if literal_regexp?
                  Regexp.new @statement[1..-2]
                else
                  @context.symbols.statement_to_regexp(@statement)
                end
    end

    def defines_symbols?
      'AIEMLDXS'.include?(type) && !(pattern? && literal_regexp?)
    end

    private

    def literal_regexp?
      @statement[0] == '/' && @statement[-1] == '/'
    end

    # Sets the final acceptance code, title, and key for the statement by
    # dispatching to the appropriate type handler (tautology, definition, etc.)
    # based on the initial code letter. Raises if type unsupported.
    # :reek:DuplicateMethodCall
    def set_acceptance_code
      handler = TYPE_HANDLERS[@code[0]]
      raise(Error, "type #{@code[0]} not implemented") unless handler

      send(handler)
    end

    # :reek:TooManyStatements
    # rubocop: disable Metrics/CyclomaticComplexity
    # rubocop: disable Metrics/PerceivedComplexity
    def set_statement(support = nil, title = nil, undefined: nil)
      @code  = "#{@code[0]}#{@statement_number}"
      @code += ".#{@section}" unless @section == '-'
      @key   = @code.to_sym
      @code += "/#{support}" if support
      @title = title if (title = title&.split(':', 2)&.first) && !title.empty?
      return unless undefined && !undefined.empty?

      @title = "#{@title}: #{undefined.join(' ')}"
    end
    # rubocop: enable Metrics/PerceivedComplexity
    # rubocop: enable Metrics/CyclomaticComplexity

    def pattern_type_support(follows)
      support(*follows) if @regexp.match?(follows.map(&:to_s).join("\n"))
    end

    def support(*statements)
      statements.map { it.code.split('/', 2)[0] }.join(',')
    end

    # Pattern helpers

    # nlc: "\n" count
    def newlines_count(nlc)
      return if nlc == @regexp.inspect.gsub('\\\\', '').scan('\\n').length

      raise Error, "expected #{nlc} newlines"
    end

    # Searches

    def detect_statement(type)
      # Check explicit support in @code (e.g. "/A12")
      if (support_key = @code[%r{(?<=/)[^,]+}]) &&
         (pattern = @context.get(support_key.to_sym)) &&
         pattern.match?(@statement)
        return pattern
      end

      # Fallback: search all patterns of given type
      @context.type(type).find { it.match? @statement } ||
        raise(Error, "no matching '#{type}' pattern")
    end

    # :reek:DuplicateMethodCall
    # :reek:NestedIterators
    # :reek:TooManyStatements
    # rubocop: disable Metrics/AbcSize
    # rubocop: disable Metrics/MethodLength
    def heap_combos_search(type)
      if (md = %r{/([^,]+),([^,]+),([^,]+)$}.match @code)
        inference, s1, s2 = md.captures.map { @context.get it.to_sym }
        if inference
          compound = [s1, s2, @statement].join("\n")
          return inference, s1, s2 if inference.match?(compound)
        end
      end
      @context.heap.combos do |s1, s2|
        compound = [s1, s2, @statement].join("\n")
        @context.type(type).each do |inference|
          return inference, s1, s2 if inference.match?(compound)
        end
      end
      raise Error, "does not match any '#{type}' statement"
    end
    # rubocop: enable Metrics/MethodLength
    # rubocop: enable Metrics/AbcSize

    # :reek:DuplicateMethodCall
    # :reek:NestedIterators
    # :reek:TooManyStatements
    # rubocop: disable Metrics/MethodLength
    def heap_search(type)
      if (md = %r{/([^,]+),([^,]+)$}.match @code)
        s0, s1 = md.captures.map { @context.get it.to_sym }
        if s0
          compound = [s1, @statement].join("\n")
          return s0, s1 if s0.match?(compound)
        end
      end
      @context.heap.each do |s1|
        compound = [s1, @statement].join("\n")
        @context.type(type).each do |s0|
          return s0, s1 if s0.match?(compound)
        end
      end
      raise Error, "does not match any '#{type}' statement"
    end
    # rubocop: enable Metrics/MethodLength

    # Defined/Undefined

    # :reek:ControlParameter title
    # :reek:DuplicateMethodCall { allow_calls: [ undefined.empty? ] }
    def expected_instantiations(title = nil, instantiations: nil)
      undefined = @context.symbols.undefined(self)
      if instantiations ||= title&.match_to_i(/[1-9]\d*/)
        unless instantiations == undefined.length
          raise Error,
                "expected #{instantiations} undefined: #{undefined.join(' ')}"
        end
      elsif undefined.empty?
        raise Error, 'nothing was undefined'
      end
      undefined.empty? ? nil : undefined
    end
  end
  # rubocop: enable Metrics/ClassLength
end
