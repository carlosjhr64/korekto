# frozen_string_literal: true

module Korekto
  # Manages Korekto symbols, variable-to-type mappings, and type-to-pattern
  # mappings. Provides methods to scan statements, detect undefined symbols,
  # define symbols, and convert statements to regular expression patterns or
  # Regexp objects.
  class Symbols
    attr_reader :type_to_pattern, :variable_to_type

    def initialize
      # Set of Korekto symbols(String tokens)
      @set = Set.new
      @variable_to_type = {}
      @type_to_pattern = {}
      @scanner = /:\w+|./ # Default scanner
    end

    def scanner=(value)
      @scanner = Regexp.new(value)
    end

    def undefined(statement, set: Set.new)
      return set if statement.literal_regexp?

      statement.scan(@scanner) do |token|
        set << token unless @set.include?(token) ||
                            (statement.pattern? &&
                             @variable_to_type.include?(token))
      end
      set
    end

    def define!(statement) = undefined(statement).each { |token| @set << token }

    def statement_to_regexp(statement)
      return Regexp.new statement[1..-2] if statement[0] == '/' &&
                                            statement[-1] == '/'

      pattern, count = statement_to_pattern(statement)
      raise Error, 'pattern with no captures' if count < 1

      Regexp.new("\\A#{pattern}\\Z")
    end

    # Converts a statement into a regex pattern and capture count.
    # Replaces defined variables with their type patterns, quotes literals,
    # and assigns capture groups to variables. Returns [pattern, captures].
    def statement_to_pattern(statement, quote: true)
      seen = {}
      # Build pattern from statement token by token.
      parts = statement.scan(@scanner).map do |token|
        token_to_pattern(seen, token, quote)
      end
      [parts.join, seen.size]
    end

    private

    def token_to_pattern(seen, token, quote)
      return "\\#{seen[token]}" if seen.key?(token)
      return '' unless (type = @variable_to_type[token]) || quote
      return regexed(type, seen, token) if type

      Regexp.quote(token).sub(/^(\d)/, '[\1]')
    end

    def regexed(type, seen, token)
      regex = @type_to_pattern[type]
      return regex if type.start_with?('.')

      seen[token] = (seen.size + 1).to_s
      "(#{regex})"
    end
  end
end
