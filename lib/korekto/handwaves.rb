# frozen_string_literal: true

module Korekto
  # Manages a collection of "Handwave" transformations that transform
  # one true statement into another true statement.
  # For more complicated cases where Korekto's main mechanic of
  # Regexp pattern matching is insufficient.
  class Handwaves
    def initialize(context)
      @context   = context
      @handwaves = []
      @captures  = []
    end

    def push(handwave)
      raise Error, 'duplicate handwave' if @handwaves.include?(handwave)
      raise Error, 'unrecognized handwave' unless /^:/.match?(handwave)

      @handwaves.push(handwave)
    end

    # Verify statement satisfies a handwave
    def check!(statement)
      raise Error, 'no handwaves found' unless @handwaves.any? do |handwave|
        case handwave
        when /^:/ # Ex Handwave
          ex_handwave?(handwave[1..], statement)
        else
          # Bug: should not happen... Catch this in `push`.
          raise "unrecognized: #{handwave}"
        end
      end
    end

    private

    # Applies a Vim Ex-style handwave transformation chain to verify that
    # `statement` can be derived from the current antecedent via a sequence
    # of match (m/M/g), translate (t), and substitution (s) steps.
    # Returns true if the final `consequent` equals `statement`;
    # otherwise false. Captures from match steps are stored in @captures
    # for use in substitutions.
    def ex_handwave?(command, statement)
      @captures.clear
      consequent = @context.antecedent.dup
      command.split('|').each do |step|
        break unless
          ex_step?(step, statement, consequent)
      end
      statement == consequent
    end

    def ex_step?(step, statement, consequent)
      case step
      when %r{^([mM])/(.*)/(t)?$}
        ex_match_statement?(statement, *Regexp.last_match[1..3])
      when %r{^g/(.*)/(t)?$}
        ex_match_heap?(*Regexp.last_match[1..2])
      when %r{^s/(.*?)/(.*)/(g)?$}
        ex_gsub_consequent?(consequent, *Regexp.last_match[1..3])
      else
        raise Error, "unrecognized handwave step: #{step}"
      end
    end

    def statement_to_pattern(pattern)
      @context.symbols.statement_to_pattern(pattern, quote: false)
    end

    def ex_match_statement?(statement, command, pattern, translate)
      pattern, = statement_to_pattern(pattern) if translate
      string = command == 'M' ? @context.antecedent : statement
      md = Regexp.new(gsub!(pattern)).match(string)
      return false unless md

      @captures.push(*md[1..])
      true
    end

    def ex_match_heap?(pattern, translate)
      pattern, = statement_to_pattern(pattern) if translate
      rgx = Regexp.new(gsub!(pattern))
      md = nil
      return false unless @context.heap.any? { (md = rgx.match it) }

      @captures.push(*md[1..])
      true
    end

    def ex_gsub_consequent?(consequent, pattern, substitute, global)
      rgx = Regexp.new(gsub!(pattern))
      gsub!(substitute) # implement captures from prior matches
      if global
        consequent.gsub!(rgx, substitute)
      else
        consequent.sub!(rgx, substitute)
      end
      true
    end

    def gsub!(pattern)
      # Reverse to replace higher-index captures ($10, $11, ...)
      # before lower ones ($1, $2) to avoid overlap.
      @captures.each_with_index.reverse_each do |x, i|
        pattern.gsub!("$#{i + 1}", x)
      end
      pattern
    end
  end
end
