class Korekto
  class Statements
    class Error < RuntimeError; end

    SYMBOLS = Symbols.new
    S2R     = StatementToRegexp.new
    HEAP    = Heap.new(13)

    attr_reader :statement,:code,:title
    def initialize
      @h = {}
      @statement = @code = @title = nil
    end

    def to_h
      @h
    end

    def type(c)
      @h.select{_2[0]==c}
    end

    def length
      @h.length
    end

    def key?(statement)
      @h.key?(statement)
    end

    def add(statement, code, title)
      if code_title = @h[statement]
        # Restatement
        code,_ = code_title.split(' ', 2)
        title ||=_
        return code, title
      end
      @statement,@code,@title = statement,code,title
      syntax_check
      @heap = true
      set_acceptance_code
      HEAP.add @statement if @heap
      return @code, @title
    end

    private

    def set_statement(code, support=nil, title=nil)
      @code = "#{code}#{ @h.length + 1 }"
      @code += "/#{support}" if support
      @title = title if title and not @title
      @h[@statement] = (@title)? "#{@code} #{@title}" : @code
    end

    def syntax_check
      SYNTAX.each do |rule|
        raise Error, "syntax: #{rule}" unless @statement.instance_eval(rule)
      rescue
        raise "#{$!.class}: #{rule}"
      end
    end

    def set_acceptance_code
      case @code[0]
      when 'D'
        definition
      when 'P'
        postulate
      when 'A'
        axiom
      when 'T'
        tautology
      when 'I'
        inference
      when 'C'
        conclusion
      else
        raise "Statement type #{@code} not supported."
      end
    end

=begin
    # TODO: not sure I want this
    def tautology?
      type('A').any?{|statement, code| S2R[statement].match? @statement}
    end

    def inferable?
      mapping,*_ = infer
      not mapping.nil?
    end

    def assert_not_provable
      raise Error, 'tautology' if tautology?
      raise Error, 'inferable' if inferable?
    end
=end

    def definition
      raise Error, 'nothing was undefined' if SYMBOLS.undefined(@statement).empty?
#     assert_not_provable unless OPTIONS.fast?
      SYMBOLS.define! @statement
      set_statement('D')
    end

    def all_defined
      unless (u = SYMBOLS.undefined(@statement)).empty?
        raise Error, "undefined: #{u.join(' ')}"
      end
    end

    def postulate
      all_defined
#     assert_not_provable unless OPTIONS.fast?
      set_statement('P')
    end

    def axiom
      S2R[@statement] # memoize/register
      @heap = false # Axioms are statements about single statements
      set_statement('A')
    end

    def tautology
      all_defined
      axiom, code = type('A').detect do |statement, code|
        S2R[statement].match? @statement
      end
      raise Error, "does not match any axiom" unless axiom
      support,title = code.split(' ', 2)
      support,_ = support.split('/', 2)
      set_statement('T', support, title)
    end

    def inference
      S2R[@statement]
      @heap = false # Inference are statements about compound statements
      set_statement('I')
    end

    def conclusion
      all_defined
      inference,s1,s2 = infer
      raise Error, "does not match any inference" unless inference
      cm,title = @h[inference].split(' ',2)
      c1,_ = @h[s1].split(' ',2); c1,_ = c1.split('/', 2)
      c2,_ = @h[s2].split(' ',2); c2,_ = c2.split('/', 2)
      support = [cm,c1,c2].join(',')
      set_statement('C', support, title)
    end

    def infer
      HEAP.combos do |s1, s2|
        compound = [s1,s2,@statement].join("\n")
        type('I').each do |inference, code|
          return inference,s1,s2 if S2R[inference].match?(compound)
        end
      end
      return nil
    end
  end
end
