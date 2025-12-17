# frozen_string_literal: true

module Korekto
  # Manages a collection of "Handwave" transformations that transform
  # one true statement into another true statement.
  # For more complicated cases where Korekto's main mechanic of
  # Regexp pattern matching is insufficient.
  # :reek:MissingSafeMethod { exclude: [ check! ] }
  class Handwaves
    using Korekto::Refinements

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
          self.statement = statement
          self.consequent = @context.antecedent.dup
          ex_handwave?(handwave[1..])
        else
          # Bug: should not happen... Catch this in `push`.
          raise "unrecognized: #{handwave}"
        end
      end
    end

    private

    attr_accessor :statement, :consequent

    # Applies a Vim Ex-style handwave transformation chain to verify that
    # `statement` can be derived from the current antecedent via a sequence
    # of match (m/M/g), translate (t), and substitution (s) steps.
    # Returns true if the final `consequent` equals `statement`;
    # otherwise false. Captures from match steps are stored in @captures
    # for use in substitutions.
    def ex_handwave?(command)
      @captures.clear
      command.split('|').each do |step|
        break unless
          ex_step?(step)
      end
      statement == consequent
    end

    # :reek:DuplicateMethodCall { allow_calls: [ Regexp.last_match ] }
    def ex_step?(step)
      case step
      when %r{^([mM])/(.*)/(t)?$}
        ex_match_statement?(*Regexp.last_match[1..3])
      when %r{^g/(.*)/(t)?$}
        ex_match_heap?(*Regexp.last_match[1..2])
      when %r{^s/(.*?)/(.*)/(g)?$}
        ex_replace?(*Regexp.last_match[1..3])
      else
        raise Error, "unrecognized handwave step: #{step}"
      end
    end

    def statement_to_pattern(pattern)
      @context.symbols.statement_to_pattern(pattern, quote: false)
    end

    # :reek:TooManyStatements
    # :reek:ControlParameter command, translate
    def ex_match_statement?(command, pattern, translate)
      pattern, = statement_to_pattern(pattern) if translate
      pattern.gsub_tokens!(@captures)
      string = command == 'M' ? @context.antecedent : statement
      md = Regexp.new(pattern).match(string)
      return false unless md

      @captures.push(*md[1..])
      true
    end

    # :reek:TooManyStatements
    # :reek:ControlParameter translate
    def ex_match_heap?(pattern, translate)
      pattern, = statement_to_pattern(pattern) if translate
      pattern.gsub_tokens!(@captures)
      rgx = Regexp.new(pattern)
      md = nil
      return false unless @context.heap.any? { (md = rgx.match it) }

      @captures.push(*md[1..])
      true
    end

    # :reek:TooManyStatements
    # :reek:ControlParameter global
    def ex_replace?(pattern, substitute, global)
      pattern.gsub_tokens!(@captures)
      rgx = Regexp.new(pattern)
      substitute.gsub_tokens!(@captures) # implement captures from prior matches
      if global
        consequent.gsub!(rgx, substitute)
      else
        consequent.sub!(rgx, substitute)
      end
      true
    end
  end
end
