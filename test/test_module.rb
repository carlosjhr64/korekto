# frozen_string_literal: true

require 'colorize'

module TestModule
  class Coverage
    def initialize(klass, context, cl1 = :red, cl2 = :light_red, cl3 = :magenta)
      @public_methods    = klass.public_instance_methods(false).sort
      @protected_methods = klass.protected_instance_methods(false).sort
      @private_methods   = klass.private_instance_methods(false).sort
      @refinements       = klass.refinements
      @context = context
      @cl1 = cl1
      @cl2 = cl2
      @cl3 = cl3
    end

    def rename(method)
      "test_#{method}"
        .sub(/=$/, '_set')
        .sub(/!$/, '_bang')
        .sub(/\?$/, '_wut')
    end

    def test_public_methods    = @public_methods.each  { test_method it, @cl1 }
    def test_protected_methods = @private_methods.each { test_method it, @cl2 }
    def test_private_methods   = @private_methods.each { test_method it, @cl3 }

    def test_method(method, color)
      return if method.start_with? 'test_'

      name = rename(method)
      return if @context.respond_to? name.to_sym

      puts "Missing #{@context.class}##{name}".colorize(color)
    end

    def test_refinements
      @refinements.each do |refinement|
        target = refinement.target
        refinement.public_instance_methods(false).each do |method|
          test_method("#{target}_#{method}".downcase, @cl1)
        end
      end
    end
  end

  # No fail warnings
  def coverage(klass)
    coverage = Coverage.new(klass, self)
    coverage.test_public_methods
    coverage.test_protected_methods
    coverage.test_private_methods
    coverage.test_refinements
  end
end
