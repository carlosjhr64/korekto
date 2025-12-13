# frozen_string_literal: true

# rubocop: disable Metrics
module TestModule
  # No fail warnings
  def coverage(klass)
    public_methods    = klass.public_instance_methods(false)
    protected_methods = klass.protected_instance_methods(false)
    private_methods   = klass.private_instance_methods(false)
    (public_methods + protected_methods + private_methods).each do |method|
      next if method.start_with? 'test_'

      test_method = "test_#{method}"
      test_method.sub!(/=$/, '_set')
      test_method.sub!(/!$/, '_bang')
      test_method.sub!(/\?$/, '_wut')
      next if respond_to? test_method.to_sym

      color = :red
      color = :light_red if protected_methods.include?(method)
      color = :magenta if private_methods.include?(method)
      puts "Missing #{self.class}##{test_method}".colorize(color)
    end
  end
end
# rubocop: enable Metrics
