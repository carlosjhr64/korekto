# frozen_string_literal: true

module Korekto
  # Context searches for Korekto::Statement
  # :reek:UncommunicativeVariableName { accept: [ s0, s1, s2 ] }
  module ContextSearch
    def follows_get(nlc) = @context.heap.follows(nlc)

    def detect_statement(type, statement = @s.statement)
      # Check explicit support in code (e.g. "/A12")
      if (support_key = @s.code[%r{(?<=/)[^,]+}]) &&
         (pattern = @context.get(support_key.to_sym)) &&
         pattern.match?(statement)
        return pattern
      end

      # Fallback: search all patterns of given type
      @context.type(type).find { it.match? statement } ||
        raise(Error, "no matching '#{type}' pattern")
    end

    def heap_combos_search_code
      if (md = %r{/([^,]+),([^,]+),([^,]+)$}.match @s.code)
        inference, s1, s2 = md.captures.map { @context.get it.to_sym }
        if inference
          compound = [s1, s2, @s.statement].join("\n")
          return inference, s1, s2 if inference.match?(compound)
        end
      end
      nil
    end

    # :reek:NestedIterators and :reek:TooManyStatements
    def heap_combos_search_all
      inferences = @context.type(@s.type)
      @context.heap.combos do |s1, s2|
        compound = [s1, s2, @s.statement].join("\n")
        inferences.each do |inference|
          return inference, s1, s2 if inference.match?(compound)
        end
      end
      nil
    end

    def heap_combos_search
      heap_combos_search_code ||
        heap_combos_search_all or
        raise Error, "does not match any '#{@s.type}' statement combos in heap"
    end

    def heap_search_code(type)
      if (md = %r{/(#{type}[^,]+),([^,]+)$}.match @s.code)
        s0, s1 = md.captures.map { @context.get it.to_sym }
        if s0
          compound = [s1, @s.statement].join("\n")
          return s0, s1 if s0.match?(compound)
        end
      end
      nil
    end

    # :reek:NestedIterators and :reek:TooManyStatements
    def heap_search_all(type)
      statements = @context.type(type)
      @context.heap.each do |s1|
        compound = [s1, @s.statement].join("\n")
        statements.each do |s0|
          return s0, s1 if s0.match?(compound)
        end
      end
      nil
    end

    def heap_search(type)
      heap_search_code(type) ||
        heap_search_all(type) or
        raise Error, "does not match any '#{type}' statement in heap"
    end
  end
end
