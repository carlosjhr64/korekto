# frozen_string_literal: true

module Korekto
  # Central registry managing all statements processed by Korekto.
  #
  # Stores every statement added in a session, tracking its type code,
  # title, source filename, and unique key. Detects and handles
  # restatements. Integrates with:
  # - Heap: includes inference-relevant statements (D,X,S,P,T,C,R,H)
  # - Symbols: registers defined symbols (A,I,E,M,L,D,X,S)
  # - Syntax: validates non-regex statements
  # - Handwaves: manages informal justifications
  #
  # Offers fast key-based lookup, type-based filtering, pattern
  # iteration, and restatement detection. The `add` method yields for
  # the next statement number and returns `[code, title]`.
  class Statements
    using Refinements

    attr_reader :heap, :symbols, :syntax, :handwaves, :last

    def initialize
      @statements = {}
      @heap = Heap.new Korekto.heap
      @symbols = Symbols.new
      @syntax = Syntax.new
      @handwaves = Handwaves.new(self)
      @last = nil
    end

    def type(code) = @statements.values.select { it.type == code }
    def length     = @statements.length
    def patterns   = @statements.values.select(&:pattern?).each { yield it }
    def get(key)   = @statements[key]
    def antecedent = @heap.antecedent

    def add(statement, code, title, filename)
      if (restatement = find_restatement(statement, code))
        return restated(restatement, title)
      end

      @syntax.check!(statement) unless Statement::PATTERNS.include?(code[0]) &&
                                       statement.wrapped_by?('/')
      statement_number = yield
      @last = Statement.new(self, statement, code, title, filename,
                            statement_number).struct
      update!
      [@last.code, @last.title]
    end

    private

    def update!(key = @last.key)
      raise Error, "duplicate key: #{key}" if @statements.key?(key)

      @statements[key] = @last
      @symbols.define! @last if @last.defines_symbols?
      @heap.add @last if Statement::HEAPABLE.include?(@last.type)
    end

    def find_restatement(statement, code)
      type = code[0]
      @statements.values.detect { it.same?(statement, type) }
    end

    # Handles restatement of an identical prior statement.
    # Re-adds the existing statement to the heap and returns its code/title.
    # Restatements are restricted to heap-relevant types (D,X,S,P,T,C,R,H).
    # Raises Error otherwise.
    def restated(restatement, title)
      code = restatement.code
      # Restatements are only allowed for heap-able statement types
      # (D,X,S,P,T,C,R,H) because only these participate in inference.
      # See `heap_combos_search` and `heap_search` in
      # [Korekto::Statement](statement.rb?heap_combos_search)
      unless Statement::HEAPABLE.include?(restatement.type)
        raise Error, "restatement: #{code}"
      end

      @heap.add restatement
      title ||= restatement.title
      [code, title]
    end
  end
end
