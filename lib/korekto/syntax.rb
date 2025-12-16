# frozen_string_literal: true

module Korekto
  # Manages a collection of syntax rules. Each rule is a Ruby expression that
  # evaluates on a string and returns a boolean indicating validity.
  # :reek:MissingSafeMethod
  class Syntax
    def initialize = @syntax = []

    using Refinements

    # NOTE: Warning! `instance_eval` not safe!
    def push(rule)
      validate!(rule)
      @syntax.push(rule)
    rescue StandardError
      raise if $ERROR_INFO.is_a? Error

      raise Error, "#{$ERROR_INFO.class}: #{rule}"
    end

    def check!(statement)
      rule = @syntax.detect do |rule|
        !statement.instance_eval rule
      rescue StandardError
        raise Error, "#{$ERROR_INFO.class}: #{rule}"
      end
      raise Error, "syntax: #{rule}" if rule
    end

    private

    def validate!(rule)
      raise Error, 'duplicate syntax' if @syntax.include?(rule)

      # ensure it'll eval on string and returns boolean
      return if ''.instance_eval(rule) in TrueClass | FalseClass

      raise Error, 'syntax must eval boolean'
    end
  end
end
