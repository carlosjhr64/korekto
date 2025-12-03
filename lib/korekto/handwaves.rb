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

    def to_a = @handwaves

    def push(handwave)
      raise Error, 'duplicate handwave' if @handwaves.include?(handwave)

      @handwaves.push(handwave)
    end

    def gsub!(pattern)
      # Reverse to replace higher-index captures ($10, $11, ...)
      # before lower ones ($1, $2) to avoid overlap.
      @captures.each_with_index.reverse_each do |x, i|
        pattern.gsub!("$#{i + 1}", x)
      end
      pattern
    end

    # Verify statement satisfies a handwave
    def check(statement)
      raise Error, 'no handwaves found' unless @handwaves.any? do |handwave|
        case handwave
        when /^:/ # Ex Handwave
          ex_handwave?(handwave[1..], statement)
        else
          raise "unrecognized: #{handwave}"
        end
      end
    end

    # The "Ex Handwave" is a chain of Vim Ex-style commands (m, M, g, s)
    # prefixed with ':' and separated by '|',
    # similar to :m/pattern/|s/find/replace/.
    def ex_handwave?(command, statement)
      @captures.clear
      symbols = @context.symbols
      heap = @context.heap.to_a
      antecedent = heap.first.to_s
      consequent = antecedent.dup
      command.split('|').each do |step|
        break unless
          ex_step?(step, statement, antecedent, consequent, symbols, heap)
      end
      statement == consequent
    end

    private

    # rubocop: disable Metrics/ParameterLists
    def ex_step?(step, statement, antecedent, consequent, symbols, heap)
      case step
      when %r{^([mM])/(.*)/(t)?$}
        ex_match_statement?(statement, antecedent, Regexp.last_match)
      when %r{^g/(.*)/(t)?$}
        ex_match_heap?(heap, symbols, Regexp.last_match)
      when %r{^s/(.*?)/(.*)/(g)?$}
        ex_gsub_consequent?(consequent, Regexp.last_match)
      else
        raise Error, "unrecognized handwave step: #{step}"
      end
    end
    # rubocop: enable Metrics/ParameterLists

    def ex_match_statement?(statement, antecedent, matchdata)
      command = matchdata[1]
      pattern = matchdata[2]
      t = matchdata[3]
      n = 0
      pattern, n = symbols.statement_to_pattern(pattern, quote: false) if t
      string = command == 'M' ? antecedent : statement
      md = Regexp.new(gsub!(pattern)).match(string)
      return false unless md

      1.upto(n).each { @captures.push(md[it]) }
      true
    end

    def ex_match_heap?(heap, symbols, matchdata)
      pattern = matchdata[1]
      t = matchdata[2]
      n = 0
      pattern, n = symbols.statement_to_pattern(pattern, quote: false) if t
      rgx = Regexp.new(gsub!(pattern))
      md = nil
      return false unless heap.any? { (md = rgx.match it) }

      1.upto(n).each { @captures.push(md[it]) }
      true
    end

    def ex_gsub_consequent?(consequent, matchdata)
      pattern = matchdata[1]
      substitute = matchdata[2]
      g = matchdata[3]
      rgx = Regexp.new(gsub!(pattern))
      gsub!(substitute) # implement captures from prior matches
      if g then consequent.gsub!(rgx, substitute)
      else
        consequent.sub!(rgx, substitute)
      end
      true
    end
  end
end
