# frozen_string_literal: true

module Korekto
  # Define each statement type handler
  module StatementHandlers
    private

    TYPE_HANDLERS = {
      'P' => :postulate,      # Postulate
      'D' => :definition,     # Definition
      'C' => :conclusion,     # Conclusion
      'X' => :instantiation,  # Instantiation
      'R' => :result,         # Result
      'S' => :setter,         # Setter
      'T' => :tautology,      # Tautology
      'A' => :pattern_type0,  # Axiom -> Tautology
      'L' => :pattern_type0,  # Let -> Set
      'M' => :pattern_type1,  # Map -> Result
      'E' => :pattern_type1,  # Existential -> Instantiation
      'I' => :pattern_type2,  # Inference -> Conclusion
      'H' => :handwave,       # Handwave
      'W' => :wild_card       # Wild Card
    }.freeze

    private_constant :TYPE_HANDLERS

    def pattern_type0 = pattern_type(0)
    def pattern_type1 = pattern_type(1)
    def pattern_type2 = pattern_type(2)

    def wild_card
      %w[T S R X C].any? do |code|
        @code[0] = code
        set_acceptance_code
        true
      rescue Error
        false
      end or raise Error, 'did not match any statement pattern(T/S/R/X/C)'
    end

    # nlc: "\n" count
    def pattern_type(nlc, undefined = nil)
      set_regexp
      newlines_count(nlc)
      undefined = @context.symbols.undefined(self) unless literal_regexp?
      support = pattern_type_support(@context.heap.follows(nlc))
      set_statement(support, undefined:)
    end

    # A Tautology is an accepted true statement that immediately follows from
    # an Axiom rule. It may not have any undefined terms.
    def tautology
      expected_instantiations(instantiations: 0)
      axiom = detect_statement('A')
      set_statement(support(axiom), axiom.title)
    end

    # A Setter(Assignment) is an allowed true statement that introduces
    # at least one term as immediately validated by a matching Let rule.
    def setter
      let = detect_statement('L')
      title = let.title
      undefined = expected_instantiations(title)
      set_statement(support(let), title, undefined:)
    end

    # A Result is a derived true statement that follows from a Map rule and
    # matching true statement.
    def result
      expected_instantiations(instantiations: 0)
      mapping, antecedent = heap_search('M')
      set_statement(support(mapping, antecedent), mapping.title)
    end

    # An Instantiation is a derived true statement that introduces at least one
    # new term as a result of an Existential rule and matching true statement.
    def instantiation
      existential, antecedent = heap_search('E')
      title = existential.title
      undefined = expected_instantiations(title)
      set_statement(support(existential, antecedent), title, undefined:)
    end

    # A Conclusion is a derived true statement, the result of an Inference rule
    # that follows from two true statements.
    def conclusion
      expected_instantiations(instantiations: 0)
      inference, conditional, antecedent = heap_combos_search('I')
      title = inference.title
      set_statement(support(inference, conditional, antecedent), title)
    end

    # A Definition is an assumed true statement that defines at least one term.
    def definition
      undefined = expected_instantiations(@title)
      # With many undefined symbols in a definition,
      # it's annoying to repeat them in the comment.
      undefined = nil if undefined.size > 2
      set_statement(undefined:)
    end

    # A Postulate is an assumed true statement with all terms defined.
    def postulate
      expected_instantiations(instantiations: 0)
      set_statement
    end

    # When the above methods are unwieldy...
    def handwave
      expected_instantiations(instantiations: 0)
      @context.handwaves.check!(@statement)
      set_statement
    end
  end
end
