# frozen_string_literal: true

require 'colorize'

# Test and warnings common to test files
module TestModule
  # Checks for context.test_method for each klass.method
  class Coverage
    # Allow color changes.
    # rubocop: disable Style/MutableConstant
    COLOR = {
      public: :red,
      protected: :light_red,
      private: :magenta,
      refinement: :cyan
    }
    # rubocop: enable Style/MutableConstant

    def initialize(klass, context)
      @klass = klass
      @context = context
    end

    def test_public_methods
      @klass.public_instance_methods(false).sort.each do |method|
        test_method method, :public
      end
    end

    def test_protected_methods
      @klass.protected_instance_methods(false).sort.each do |method|
        test_method method, :protected
      end
    end

    def test_private_methods
      @klass.private_instance_methods(false).sort.each do |method|
        test_method method, :private
      end
    end

    def test_refinements
      @klass.refinements.each do |refinement|
        test_refinement refinement, refinement.target.to_s.downcase
      end
    end

    def test_all
      test_public_methods
      test_protected_methods
      test_private_methods
      test_refinements
    end

    private

    RENAME = lambda do |method|
      "test_#{method}"
        .sub(/=$/, '_set')
        .sub(/!$/, '_bang')
        .sub(/\?$/, '_wut')
    end
    private_constant :RENAME

    # Check if context has a test for the method.
    # :reek:ManualDispatch
    def test_method(method, type)
      return if method.start_with? 'test_'

      name = RENAME[method]
      return if @context.respond_to? name.to_sym

      puts "Missing #{@context.class}##{name}".colorize COLOR[type]
    end

    def test_refinement(refinement, target)
      refinement.public_instance_methods(false).each do |method|
        test_method "#{target}_#{method}", :refinement
      end
    end
  end

  # No fail warnings
  def coverage(klass) = Coverage.new(klass, self).test_all
end
