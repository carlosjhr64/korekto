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
      'A' => :axiom,          # Axiom -> Tautology
      'L' => :let,            # Let -> Setter
      'M' => :mapper,         # Mapper -> Result
      'E' => :existential,    # Existential -> Instantiation
      'I' => :inference,      # Inference -> Conclusion
      'H' => :handwave,       # Handwave
      'W' => :wild_card       # Wild Card
    }.freeze

    private_constant :TYPE_HANDLERS

    def wild_card
      %w[T S R X C].any? do |type|
        set_type!(type)
        set_acceptance_code
        true
      rescue Error
        false
      end or raise Error, 'did not match any statement pattern(T|S|R|X|C)'
    end

    # nlc: "\n" count
    def pattern_type(nlc)
      set_regexp!
      verify_newlines_count!(nlc)
      set_code!(pattern_type_support(follows_get(nlc)))
      set_title!(undefined: undefined_symbols_get)
    end

    def axiom       = pattern_type(0)
    def let         = pattern_type(0)
    def mapper      = pattern_type(1)
    def existential = pattern_type(1)
    def inference   = pattern_type(2)

    # A Tautology is an accepted true statement that immediately follows from
    # an Axiom rule. It may not have any undefined terms.
    def tautology
      expected_instantiations!(instantiations: 0)
      axiom = detect_statement('A')
      set_code!(support(axiom))
      set_title!(axiom.title)
    end

    # A Setter(Assignment) is an allowed true statement that introduces
    # at least one term as immediately validated by a matching Let rule.
    def setter
      let = detect_statement('L')
      title = let.title
      undefined = expected_instantiations!(title)
      set_code!(support(let))
      set_title!(title, undefined:)
    end

    # A Result is a derived true statement that follows from a Map rule and
    # matching true statement.
    def result
      expected_instantiations!(instantiations: 0)
      mapping, antecedent = heap_search('M')
      set_code!(support(mapping, antecedent))
      set_title!(mapping.title)
    end

    # An Instantiation is a derived true statement that introduces at least one
    # new term as a result of an Existential rule and matching true statement.
    def instantiation
      existential, antecedent = heap_search('E')
      title = existential.title
      undefined = expected_instantiations!(title)
      set_code!(support(existential, antecedent))
      set_title!(title, undefined:)
    end

    # A Conclusion is a derived true statement, the result of an Inference rule
    # that follows from two true statements.
    def conclusion
      expected_instantiations!(instantiations: 0)
      inference, conditional, antecedent = heap_combos_search('I')
      title = inference.title
      set_code!(support(inference, conditional, antecedent))
      set_title!(title)
    end

    # A Definition is an assumed true statement that defines at least one term.
    def definition
      undefined = expected_instantiations!
      # With many undefined symbols in a definition,
      # it's annoying to repeat them in the comment.
      undefined = nil if undefined.size > 2
      set_code!
      set_title!(undefined:)
    end

    # A Postulate is an assumed true statement with all terms defined.
    def postulate
      expected_instantiations!(instantiations: 0)
      set_code!
      set_title!
    end

    # When the above methods are unwieldy...
    def handwave
      expected_instantiations!(instantiations: 0)
      handwaves_check!
      set_code!
      set_title!
    end
  end
end
