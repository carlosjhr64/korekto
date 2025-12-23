# frozen_string_literal: true

# Korekto::StatementStruct will be the items of Korekto::Statements.
# The struct contains the statement and its attributes.
# Once constructed, it'll be completely frozen.
module Korekto
  STRUCT_ARGS = %i[statement code title section statement_number].freeze
  STRUCT_MORE = %i[regexp key type].freeze
  STRUCT_BOOL = %i[pattern? literal_regexp? defines_symbols?].freeze
  # Define Korekto::StatementStruct
  StatementStruct = Struct.new(*STRUCT_ARGS, *STRUCT_MORE, *STRUCT_BOOL) do
    def to_s = statement
    def to_str = statement

    # :reek:BooleanParameter
    def respond_to_missing?(symbol, bool = false)
      return true if regexp&.public_methods(false)&.include?(symbol) ||
                     statement.public_methods(false).include?(symbol)

      super
    end

    # Try to avoid this, but:
    def method_missing(symbol, ...)
      warn "method missing: Korekto::StatementStruc##{symbol}" if Korekto.trace?
      if regexp&.public_methods(false)&.include?(symbol)
        regexp.send(symbol, ...)
      elsif statement.public_methods(false).include?(symbol)
        statement.send(symbol, ...)
      else
        super
      end
    end
  end
end
