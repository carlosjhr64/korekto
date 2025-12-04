# frozen_string_literal: true

module Korekto
  # Represents a single Korekto statement.
  # A Statement is created from a raw line of text together with metadata
  # (code, title, section, number, and proof context). It determines its
  # logical role (postulate, definition, tautology, set, result, etc.)
  # by matching against previously registered pattern statements
  # (axioms, let-rules, map-rules, inference-rules, …) and by analysing
  # which symbols are undefined in the current context.
  # The class is immutable after initialization
  # rubocop: disable Metrics
  class Statement
    attr_reader :code, :title, :regexp, :section, :statement_number, :key

    def initialize(statement, code, title, section, statement_number, context)
      @statement        = statement.freeze
      @code             = code
      @title            = title
      @section          = section.freeze
      @statement_number = statement_number.freeze
      @context          = context
      @regexp           = nil
      @key              = nil
      @title            = @title.split(':', 2).first if @title
      set_acceptance_code
      @code.freeze
      @title.freeze
      @regexp.freeze
    end

    def type              = @code[0]
    def to_s              = @statement
    def to_str            = @statement
    def match?(statement) = @regexp.match?(statement)
    def scan(regex, &)    = @statement.scan(regex, &)
    def pattern?          = !@regexp.nil?
    def literal_regexp?   = @statement[0] == '/' && @statement[-1] == '/'

    def set_regexp
      @regexp = @context.symbols.statement_to_regexp(@statement)
    end

    TYPE_HANDLERS = {
      'P' => :postulate,      # Postulate
      'D' => :definition,     # Definition
      'C' => :conclusion,     # Conclusion
      'X' => :instantiation,  # Instantiation
      'R' => :result,         # Result
      'S' => :set,            # Set
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

    private

    def set_acceptance_code
      handler = TYPE_HANDLERS[@code[0]]
      raise(Error, "type #{@code[0]} not implemented") unless handler

      send(handler)
    end

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
      end or raise Error, 'did not match any statement pattern'
    end

    # Common helper

    def set_statement(support = nil, title = nil, undefined: nil)
      @code  = "#{@code[0]}#{@statement_number}"
      @code += ".#{@section}" unless @section == '-'
      @key   = @code.to_sym
      @code += "/#{support}" if support
      @title = title if (title = title&.split(':', 2)&.first) && !title.empty?
      @title = "#{@title}: #{undefined.join(' ')}" if undefined
    end

    def support(*statements)
      statements.inject([]) do |codes, statement|
        codes.push(statement.code.split('/', 2)[0])
      end.join(',')
    end

    # Pattern helpers

    # nlc: "\n" count
    def newlines_count(nlc)
      return if nlc == @regexp.inspect.gsub('\\\\', '').scan('\\n').length

      raise Error, "expected #{nlc} newlines"
    end

    # Searches

    def detect_statement(type)
      if (md = %r{/([^,]+)$}.match @code) &&
         (pattern = @context.get md[1].to_sym) &&
         pattern.match?(@statement)
        return pattern
      end

      @context.type(type).detect { it.match? @statement } ||
        raise(Error, "does not match any '#{type}' statement")
    end

    def heap_combos_search(type)
      if (md = %r{/([^,]+),([^,]+),([^,]+)$}.match @code)
        inference, s1, s2 = md.captures.map { @context.get it.to_sym }
        if inference
          compound = [s1, s2, @statement].join("\n")
          return inference, s1, s2 if inference.match?(compound)
        end
      end
      @context.heap.combos do |s1, s2|
        compound = [s1, s2, @statement].join("\n")
        @context.type(type).each do |inference|
          return inference, s1, s2 if inference.match?(compound)
        end
      end
      raise Error, "does not match any '#{type}' statement"
    end

    def heap_search(type)
      if (md = %r{/([^,]+),([^,]+)$}.match @code)
        s0, s1 = md.captures.map { @context.get it.to_sym }
        if s0
          compound = [s1, @statement].join("\n")
          return s0, s1 if s0.match?(compound)
        end
      end
      @context.heap.each do |s1|
        compound = [s1, @statement].join("\n")
        @context.type(type).each do |s0|
          return s0, s1 if s0.match?(compound)
        end
      end
      raise Error, "does not match any '#{type}' statement"
    end

    # Defined/Undefined

    # rubocop: disable Style/SafeNavigationChainLength
    def expected_instantiations(title = nil, instantiations: nil)
      undefined = @context.symbols.undefined(self)
      if instantiations ||= title&.match(/[1-9]\d*/)&.to_s&.to_i
        unless instantiations == undefined.length
          raise Error,
                "expected #{instantiations} undefined: #{undefined.join(' ')}"
        end
      elsif undefined.empty?
        raise Error, 'nothing was undefined'
      end
      undefined.empty? ? nil : undefined
    end
    # rubocop: enable Style/SafeNavigationChainLength

    # Statement type processing

    # nlc: "\n" count
    def pattern_type(nlc)
      set_regexp
      newlines_count(nlc)
      undefined = (u = @context.symbols.undefined(self)).empty? ? nil : u
      follows = @context.heap.to_a[0..nlc].reverse
      support = if @regexp.match?(follows.map(&:to_s).join("\n"))
                  support(*follows)
                end
      set_statement(support, undefined:)
    end

    # A Tautology is an accepted true statement that immediately follows from
    # an Axiom rule. It may not have any undefined terms.
    def tautology
      expected_instantiations(instantiations: 0)
      axiom = detect_statement('A')
      set_statement(support(axiom), axiom.title)
    end

    # A Set(Assignment) is an allowed true statement that introduces
    # at least one term as immediately validated by a matching Let rule.
    def set
      let = detect_statement('L')
      undefined = expected_instantiations(let.title)
      set_statement(support(let), let.title, undefined:)
    end

    # A Result is a derived true statement that follows from a Map rule and
    # matching true statement.
    def result
      expected_instantiations(instantiations: 0)
      mapping, s1 = heap_search('M')
      set_statement(support(mapping, s1), mapping.title)
    end

    # An Instantiation is a derived true statement that introduces at least one
    # new term as a result of an Existential rule and matching true statement.
    def instantiation
      existential, s1 = heap_search('E')
      undefined = expected_instantiations(existential.title)
      set_statement(support(existential, s1), existential.title, undefined:)
    end

    # A Conclusion is a derived true statement, the result of an Inference rule
    # that follows from two true statements.
    def conclusion
      expected_instantiations(instantiations: 0)
      inference, s1, s2 = heap_combos_search('I')
      set_statement(support(inference, s1, s2), inference.title)
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
      @context.handwaves.check(@statement)
      set_statement
    end
  end
  # rubocop: enable Metrics
end
