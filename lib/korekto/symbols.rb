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

    def undefined(statement)
      set = Set.new
      return set if statement.pattern? && statement.literal_regexp?

      statement.scan(@scanner) do |w|
        set << w unless @set.include?(w) ||
                        (statement.pattern? && @variable_to_type.include?(w))
      end
      set
    end

    def define!(statement) = undefined(statement).each { |w| @set << w }

    def statement_to_pattern(statement, quote: true)
      pattern = String.new
      count = 0
      seen = {}
      # Build pattern from statement token by token, v.
      statement.scan(@scanner) do |v|
        if (n = seen[v])
          pattern << "\\#{n}"
        elsif (type = @variable_to_type[v])
          regex = @type_to_pattern[type]
          if type.start_with?('.')
            # No capture patterns start with '.'
            pattern << regex
          else
            count += 1
            seen[v] = String.new(count.to_s)
            pattern << "(#{regex})"
          end
        else
          next unless quote

          # Escape Regexp specials
          v = Regexp.quote(v)
          # To avoid collisions with back-references,
          # isolate digit in square brackets:
          if '0123456789'.include?(char = v[0])
            v[0] = "[#{char}]"
          end
          pattern << v
        end
      end
      [pattern, count]
    end

    def statement_to_regexp(statement)
      return Regexp.new statement[1..-2] if statement[0] == '/' &&
                                            statement[-1] == '/'

      pattern, count = statement_to_pattern(statement)
      raise Error, 'pattern with no captures' if count < 1

      Regexp.new("\\A#{pattern}\\Z")
    end
  end
end
