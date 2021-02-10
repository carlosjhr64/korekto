class Korekto
  VERSION = '0.0.210210'

  class KorektoError < Exception
  end

  SYNTAX = []

  STATEMENTS = {}

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
    when /^! (\w.*)$/ # rule
      SYNTAX.push $1.strip
      false
    when %r{^(?<statement>.*)\s#(?<code>[A-Z](\d+(/[A-Z]\d+(,[A-Z]\d+)*)?)?)( (?<title>[A-Z][\w\s]*\w))?$}
      # Valid statements must end with commentary like #X101:Y12,Z80  Statement title
      @statement,@code,@title = $~[:statement].strip,$~[:code],$~[:title]
      true
    when /^(.*)\s#! (\w[^#]*)$/
      # Some exception in statement
      @statement,@code,@title = $1.strip,'!',$2
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

  def set_acceptance_code
    heap = true
    if code_title = STATEMENTS[@statement]
      # Restatement
      @code,title = code_title.split(' ',2)
      # Use the restatement commentary if given:
      @title=title unless @title
    else
      case @code
      when /^P/
        # Premise
        set_statement('P')
      when /^A/
        heap = false # Axioms are statements about single statements
        raise "TODO: Axiom ~ #{@statement}" unless @statement[0]=='/' and @statement[-1]=='/'
        set_statement('A')
      when /^X/
        # by aXiom
        axiom, code = STATEMENTS.detect do |statement, code|
          next unless code[0]=='A' # Axiom
          case statement
          when %r{^/.*/$}
            Regexp.new(statement[1...-1]).match?(@statement)
          else
            raise "TODO: Axiom ~ #{statement}"
          end
        end
        raise KorektoError, "does not match any axiom" unless axiom
        set_statement('X',*code.split(' ',2)) # TODO: supporting Axiom
      when /^M/
        heap = false # Mappings are statements about compound statements
        raise "TODO: Mapping ~ #{@statement}" unless @statement[0]=='/' and @statement[-1]=='/'
        set_statement('M')
      when /^C/
        mapping = nil
        s1,s2,s3 = nil,nil,@statement
        HEAP_COMBOS.each do |i,j|
          s1,s2 = HEAP[i],HEAP[j]
          compound = [s1,s2,s3].join("\n")
          mapping, code = STATEMENTS.detect do |statement, code|
            next unless code[0]=='M' # Mapping
            case statement
            when %r{^/.*/$}
              Regexp.new(statement[1...-1]).match?(compound)
            else
              raise "TODO: Mapping ~ #{statement}"
            end
          end
          break if mapping
        end
        raise KorektoError, "does not match any mapping" unless mapping
        cm,title = STATEMENTS[mapping].split(' ',2)
        c1,_ = STATEMENTS[s1].split(' ',2)
        c2,_ = STATEMENTS[s2].split(' ',2)
        support = [cm,c1,c2].join(',')
        set_statement('C', support, title)
      else
        raise "Statement type #{@code} not supported."
      end
    end
    if heap
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
