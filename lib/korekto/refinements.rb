# frozen_string_literal: true

module Korekto
  # Refinements for String to check bracket balance and spacing tightness.
  module Refinements
    refine ::String do
      # Checks if brackets are balanced
      def balanced?(brackets = '()[]{}')
        stack = []
        chars.each do |c|
          next unless brackets.include?(c)

          q, r = brackets.index(c).divmod(2)
          if r.zero? then stack << q
          else
            stack.last == q ? stack.pop : stack << q
          end
        end
        stack.empty?
      end

      # True if none of the chars have space to their left.
      def ltight?(*chars)  = chars.all? { |c| !include?(" #{c}") }

      # True if none of the chars have space to their right.
      def rtight?(*chars)  = chars.all? { |c| !include?("#{c} ") }

      # True if all chars are both ltight and rtight.
      def tight?(*chars)   = chars.all? { |c| ltight?(c) && rtight?(c) }

      def gsub_tokens!(tokens)
        # Reverse to replace higher-index captures ($10, $11, ...)
        # before lower ones ($1, $2) to avoid overlap.
        tokens.each_with_index.reverse_each do |token, index|
          gsub!("$#{index + 1}", token)
        end
      end
    end
  end
end
