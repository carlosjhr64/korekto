# frozen_string_literal: true

module TestModule
  # No fail warnings
  # rubocop: disable Metrics/MethodLength
  def test_instance_methods_coverage
    privated = TEST_CLASS.private_instance_methods(false)
    methods = TEST_CLASS.instance_methods(false) + privated
    methods.each do |method|
      next if method.start_with? 'test_'

      test_method = "test_#{method}"
      test_method.sub!(/=$/, '_set')
      test_method.sub!(/!$/, '_bang')
      test_method.sub!(/\?$/, '_wut')
      next if respond_to? test_method.to_sym

      color = privated.include?(method) ? :magenta : :red
      puts "Missing #{self.class}##{test_method}".colorize(color)
    end
  end
  # rubocop: enable Metrics/MethodLength
end
