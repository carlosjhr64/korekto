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
          process_step?(step, statement, antecedent, consequent, symbols, heap)
      end
      statement == consequent
    end

    private

    def process_step?(step, statement, antecedent, consequent, symbols, heap)
      case step
      when %r{^([mM])/(.*)/(t)?$}
        command = Regexp.last_match(1)
        pattern = Regexp.last_match(2)
        t = Regexp.last_match(3)
        n = 0
        pattern, n = symbols.statement_to_pattern(pattern, quote: false) if t
        string = command == 'M' ? antecedent : statement
        md = Regexp.new(gsub!(pattern)).match(string)
        return false unless md

        1.upto(n).each { @captures.push(md[it]) }
      when %r{^g/(.*)/(t)?$}
        pattern = Regexp.last_match(1)
        t = Regexp.last_match(2)
        n = 0
        if t
          pattern, n = symbols.statement_to_pattern(Regexp.last_match(1),
                                                    quote: false)
        end
        rgx = Regexp.new(gsub!(pattern))
        md = nil
        return false unless heap.any? { (md = rgx.match it) }

        1.upto(n).each { @captures.push(md[it]) }
      when %r{^s/(.*?)/(.*)/(g)?$}
        pattern = Regexp.last_match(1)
        substitute = Regexp.last_match(2)
        g = Regexp.last_match(3)
        rgx = Regexp.new(gsub!(pattern))
        gsub!(substitute)
        if g
          consequent.gsub!(rgx, substitute)
        else
          consequent.sub!(rgx, substitute)
        end
      else
        raise Error, "unrecognized handwave step: #{step}"
      end
      true
    end
  end
end
