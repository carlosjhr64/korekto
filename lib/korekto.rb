require 'korekto/symbols'

class Korekto
  VERSION = '0.0.210212'

  class KorektoError < Exception
  end

  SYMBOLS = Symbols.new

  SYNTAX = []

  # TODO:
  LOGIC = {}
  TYPE = {}
  PATTERN = {}

  STATEMENTS = {}
  def STATEMENTS.type(c) = select{_2[0]==c}
  StatementToRegexp = {}

  HEAP = []
  HEAP_LIMIT = 13
  # [[1, 2], [2, 1], [1, 3], [3, 1], [2, 3], [3, 2], [1, 4], [4, 1],...
  HEAP_COMBOS = (0...HEAP_LIMIT).to_a.combination(2)
    .sort{|ij, kl| ij[0]**2 + ij[1]**2 <=> kl[0]**2 + kl[1]**2}
    .map{|i, j| [[i,j], [j,i]]}
    .inject([]){|a, ij_kl| a<<ij_kl[0]; a<<ij_kl[1]}


  def initialize(filename='-')
    @filename = filename
    @active = false
    @line_number = 0
    @statement = @code = @title = nil
  end

  def active?
    case @line
    when /^```korekto$/
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

  # TODO:
  def pattern(name, pattern)
    raise "name #{name} in use" if PATTERN.has_key? name
    PATTERN[name] = Regexp.new(pattern)
  end

  # TODO:
  def types(name, variables)
    pattern = PATTERN[name]
    raise "name #{name} not defined" unless pattern
    variables.each do |variable|
      raise "variable #{variable} in use" if TYPE.has_key? variable
      raise "variable #{variable} in pattern #{name}: #{pattern.inspect}" if pattern.match? variable
      TYPE[variable] = name
    end
  end

  def statement?
    case @line
    when /^\s*#/ # comment
      false
    when %r{^< ([/\w\-.]+)$} # import
      filename = $1.strip
      Korekto.new(filename).run
      false
    when /^(::[A-Z]\w+)#(\w+)([^=]*=.+)$/ # patch
      klass,method,definition = $1,$2,$3
      raise "overides: #{klass}##{method}" if eval(klass).method_defined? method
      eval <<~EVAL
        class #{klass}
          def #{method}#{definition}
        end
      EVAL
      false
    when /^[?] (\w.*)$/
      SYNTAX.push $1.strip
      false
    when %r{^! (\p{L}|:\w+)/(.*)/$}
      # TODO:
      pattern($1, $2)
    when /^! (\p{L}|:\w+){\p{L}( \p{L})*}$/
      # TODO:
      types($1, $2.split)
    when %r{^(?<statement>.*)\s#(?<code>[A-Z](\d+(/[A-Z]\d+(,[A-Z]\d+)*)?)?)( (?<title>[A-Z][\w\s]*\w))?$}
      # Valid statements must end with commentary like #X101:Y12,Z80  Statement title
      @statement,@code,@title = $~[:statement].strip,$~[:code],$~[:title]
      true
    else
      raise 'unrecognized korekto line'
    end
  end

  def syntax_checker
    SYNTAX.each do |rule|
      raise KorektoError, "syntax: #{rule}" unless @statement.instance_eval(rule)
    rescue
      raise "#{$!.class}: #{rule}"
    end
  end

  def set_statement(code, support=nil, title=nil)
    n = STATEMENTS.length + 1
    @code = "#{code}#{n}"
    @code += "/#{support}" if support
    @title = title if title and not @title
    code_title = (@title)? "#{@code} #{@title}" : @code
    STATEMENTS[@statement] = code_title
  end

  def all_defined
    unless (u = SYMBOLS.undefined(@statement)).empty?
      raise KorektoError, "undefined: #{u.join(' ')}"
    end
  end

  def assert_not_provable
    raise KorektoError, 'tautology' if tautology?
    raise KorektoError, 'inferable' if inferable?
  end

  def definition
    raise KorektoError, 'nothing was undefined' if SYMBOLS.undefined(@statement).empty?
    assert_not_provable unless OPTIONS.fast?
    SYMBOLS.define! @statement
    set_statement('D')
  end

  def postulate
    all_defined
    assert_not_provable unless OPTIONS.fast?
    set_statement('P')
  end

  def axiom
    raise "TODO: Axiom ~ #{@statement}" unless @statement[0]=='/' and @statement[-1]=='/'
    @heap = false # Axioms are statements about single statements
    StatementToRegexp[@statement] = Regexp.new(@statement[1...-1])
    set_statement('A')
  end

  def tautology?
    STATEMENTS.type('A').any?{|statement, code| StatementToRegexp[statement].match? @statement}
  end

  def tautology
    all_defined
    axiom, code = STATEMENTS.type('A').detect do |statement, code|
      StatementToRegexp[statement].match? @statement
    end
    raise KorektoError, "does not match any axiom" unless axiom
    support,title = code.split(' ', 2)
    support,_ = support.split('/', 2)
    set_statement('T', support, title)
  end

  def inference
    raise "TODO: Inference ~ #{@statement}" unless @statement[0]=='/' and @statement[-1]=='/'
    @heap = false # Inference are statements about compound statements
    StatementToRegexp[@statement] = Regexp.new(@statement[1...-1])
    set_statement('I')
  end

  def inferable?
    mapping,*_ = infer
    not mapping.nil?
  end

  def infer
    mapping = nil
    s1,s2,s3=nil,nil,@statement
    HEAP_COMBOS.each do |i,j|
      s1,s2 = HEAP[i],HEAP[j]
      compound = [s1,s2,s3].join("\n")
      mapping, code = STATEMENTS.type('I').detect do |statement, code|
        StatementToRegexp[statement].match? compound
      end
      break if mapping
    end
    return mapping, s1, s2
  end

  def conclusion
    all_defined
    mapping,s1,s2 = infer
    raise KorektoError, "does not match any inference" unless mapping
    cm,title = STATEMENTS[mapping].split(' ',2)
    c1,_ = STATEMENTS[s1].split(' ',2); c1,_ = c1.split('/', 2)
    c2,_ = STATEMENTS[s2].split(' ',2); c2,_ = c2.split('/', 2)
    support = [cm,c1,c2].join(',')
    set_statement('C', support, title)
  end

  def restatement
    code_title = STATEMENTS[@statement]
    @code,title = code_title.split(' ',2)
    # Use the restatement commentary if given:
    @title=title unless @title
  end

  def set_acceptance_code
    @heap = true
    if STATEMENTS.key? @statement
      restatement
    else
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
    if @heap
      HEAP.unshift @statement
      HEAP.pop if HEAP.length > HEAP_LIMIT
    end
  end

  def parse(lines)
    while @line = lines.shift
      begin
        @line_number += 1
        next unless active?
        next unless statement?
        syntax_checker
        set_acceptance_code
        puts "#{@filename}:#{@line_number}:0:#{@code}:#{@title}"
      rescue KorektoError
        puts "#{@filename}:#{@line_number}:0:!:#{$!.message}"
      rescue
        puts "#{@filename}:#{@line_number}:0:?:#{$!.message}"
        exit
      end
    end
  end

  def run
    if @filename=='-'
      parse $stdin.readlines(chomp: true)
    else
      parse IO.readlines(@filename, chomp: true)
    end
  end
end
# Requires:
# `ruby`
