# frozen_string_literal: true

# Korekto::StatementStruct will be the items of Korekto::Statements.
# The struct contains the statement and its attributes.
# Once constructed, it'll be completely frozen.
module Korekto
  args = %i[statement code title section statement_number]
  more = %i[regexp key type]
  bool = %i[pattern? literal_regexp? defines_symbols?]
  # Define Korekto::StatementStruct
  StatementStruct = Struct.new(*args, *more, *bool) do
    def init!
      # These may be reset later in the struct's construction:
      self.title = title.split(':', 2) if title
      self.type = code[0]
      self[:pattern?] = false
      self[:literal_regexp?] = false
    end

    def finalize!
      self[:defines_symbols?] = !literal_regexp? && 'AIEMLDXS'.include?(type)
      each(&:freeze)
      freeze
    end

    def to_s = statement

    def respond_to_missing?(symbol, ...)
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
