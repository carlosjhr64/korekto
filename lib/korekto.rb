module Korekto
  VERSION = '0.0.210207'
  SYNTAX = []
  STATEMENTS = []

  class << self
    def active?
      case @line
      when /^```korekto\s*$/
        raise 'unexpected fence' if @active
        @active = true
        false
      when /^```\s*$/
        @active = false
        false
      else
        @active
      end
    end

    def statement?
      case @line
      when /^\s*#/ # comment
        false
      when /^!(.*)$/ # rule
        SYNTAX.push $1.strip
        false
      when /^(::[A-Z]\w+)#(.*)$/
        eval <<~EVAL
          class #{$1}
            def #{$2}
          end
        EVAL
        false
      else
        true
      end
    end

    def valid?
      valid = true
      SYNTAX.each do |rule|
        raise 'syntax' unless @line.instance_eval(rule)
      rescue
        msg = $!.message
        puts "-:#{@line_number}:0:#{msg}:#{rule}"
        if msg=='sytax'
          valid = false
          break
        else
          SYNTAX.delete rule # bad rule
        end
      end
      return valid
    end

    def main
      @active = false
      @line_number = 0
      while @line = $stdin.gets
        @line_number += 1
        @line.chomp!
        next unless active?
        next unless statement?
        @line.sub!(/\s*#.*$/,'') # strip out the comment
        STATEMENTS.push @line if valid?
      end
    end
  end
end
# Requires:
# `ruby`
