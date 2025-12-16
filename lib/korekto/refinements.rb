# frozen_string_literal: true

module Korekto
  # Refinements for String to check bracket balance and spacing tightness.
  module Refinements
    refine ::String do
      # Checks if brackets are balanced
      # :reek:DuplicateMethodCall push :reek:FeatureEnvy stack
      # :reek:TooManyStatements
      def balanced?(brackets = '()[]{}')
        stack = []
        chars.each do |char|
          next unless brackets.include?(char)

          group, index = brackets.index(char).divmod(2)
          if index.zero? then stack.push(group)
          else
            stack.last == group ? stack.pop : stack.push(group)
          end
        end
        stack.empty?
      end

      # True if none of the chars have space to their left.
      def ltight?(*chars) = chars.all? { |char| !include?(" #{char}") }

      # True if none of the chars have space to their right.
      def rtight?(*chars) = chars.all? { |char| !include?("#{char} ") }

      # True if all chars are both ltight and rtight.
      def tight?(*chars) = chars.all? { |char| ltight?(char) && rtight?(char) }

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
