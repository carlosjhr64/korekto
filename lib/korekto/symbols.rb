# frozen_string_literal: true

module Korekto
  # Manages Korekto symbols, variable-to-type mappings, and type-to-pattern
  # mappings. Provides methods to scan statements, detect undefined symbols,
  # define symbols, and convert statements to regular expression patterns or
  # Regexp objects.
  class Symbols
    attr_reader :type_to_pattern, :variable_to_type

    def initialize
      @set = Set.new # Set of Korekto symbols(strings)
      @variable_to_type = {} # Variable to Type
      @type_to_pattern = {} # Type to Pattern
      @scanner = /:\w+|./ # Default scanner
    end

    def scanner=(value)
      @scanner = Regexp.new(value)
    end

    def undefined(statement, set: Set.new)
      return set if statement.pattern? && statement.literal_regexp?

      statement.scan(@scanner) do |w|
        set << w unless @set.include?(w) ||
                        (statement.pattern? && @variable_to_type.include?(w))
      end
      set
    end

    def define!(statement) = undefined(statement).each { |w| @set << w }

    def statement_to_regexp(statement)
      return Regexp.new statement[1..-2] if statement[0] == '/' &&
                                            statement[-1] == '/'

      pattern, count = statement_to_pattern(statement)
      raise Error, 'pattern with no captures' if count < 1

      Regexp.new("\\A#{pattern}\\Z")
    end

    def statement_to_pattern(statement, quote: true)
      pattern = String.new
      seen = {}
      count = 0
      increment = -> { count += 1 }
      # Build pattern from statement token by token.
      statement.scan(@scanner) do |token|
        append_token(pattern, increment, seen, token, quote)
      end
      [pattern, count]
    end

    private

    def append_token(pattern, increment, seen, token, quote)
      if (n = seen[token])
        pattern << "\\#{n}"
      elsif (type = @variable_to_type[token])
        regex = @type_to_pattern[type]
        if type.start_with?('.')
          # No capture patterns start with '.'
          pattern << regex
        else
          n = increment.call
          seen[token] = n.to_s
          pattern << "(#{regex})"
        end
      else
        return unless quote

        # Escape Regexp specials
        quoted = Regexp.quote(token)
        # To avoid collisions with back-references,
        # isolate digit in square brackets:
        if '0123456789'.include?(char = quoted[0])
          quoted[0] = "[#{char}]"
        end
        pattern << quoted
      end
    end
  end
end
