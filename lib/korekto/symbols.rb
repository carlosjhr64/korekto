# frozen_string_literal: true

module Korekto
  # Manages Korekto symbols, variable-to-type mappings, and type-to-pattern
  # mappings. Provides methods to scan statements, detect undefined symbols,
  # define symbols, and convert statements to regular expression patterns or
  # Regexp objects.
  # :reek:MissingSafeMethod {
  #   exclude: [ define!, delete_variable!, replace_variable! ]
  # }
  class Symbols
    attr_reader :type_to_pattern, :variable_to_type

    def initialize
      # Set of Korekto symbols(String tokens)
      @set = Set.new
      @variable_to_type = {}
      @type_to_pattern = {}
      @scanner = /:\w+|./ # Default scanner
    end

    def delete_variable!(var) = @variable_to_type.delete(var)

    def replace_variable!(oldvar, newvar)
      @variable_to_type[newvar] = @variable_to_type.delete(oldvar)
    end

    def scanner=(value)
      @scanner = Regexp.new(value)
    end

    def undefined(statement, set: Set.new)
      statement.scan(@scanner) do |token|
        set << token unless @set.include?(token) ||
                            (statement.pattern? &&
                             @variable_to_type.include?(token))
      end
      set
    end

    def define!(statement) = undefined(statement).each { |token| @set << token }

    def statement_to_regexp(statement)
      pattern, count = statement_to_pattern(statement)
      raise Error, 'pattern with no captures' if count.zero?

      Regexp.new("\\A#{pattern}\\Z")
    end

    # Converts a statement into a regex pattern and capture count.
    # Replaces defined variables with their type patterns, quotes literals,
    # and assigns capture groups to variables. Returns [pattern, captures].
    # :reek:BooleanParameter quoting can be toggled
    def statement_to_pattern(statement, quote: true)
      self.seen = {}
      pattern = String.new
      # Build pattern from statement token by token.
      statement.scan(@scanner).each do |token|
        pattern << token_to_pattern(token, quote:)
      end
      [pattern, seen.size]
    end

    private

    attr_accessor :seen

    # :reek:BooleanParameter quoting can be toggled
    # :reek:ControlParameter quote
    def token_to_pattern(token, quote: true)
      return "\\#{seen[token]}" if seen.key?(token)
      if (type = @variable_to_type[token])
        return regexed(type, token)
      end

      quote ? Regexp.quote(token).sub(/^(\d)/, '[\1]') : token
    end

    def regexed(type, token)
      regex = @type_to_pattern[type]
      return regex if type.start_with?('.')

      seen[token] = (seen.size + 1).to_s
      "(#{regex})"
    end
  end
end
