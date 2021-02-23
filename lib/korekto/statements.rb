module Korekto
class Statements
  attr_reader :heap,:symbols,:syntax
  def initialize
    @statements = []
    @heap = Heap.new(13)
    @symbols = Symbols.new
    @syntax = Syntax.new
  end

  def type(c)
    @statements.select{_1.type==c}
  end

  def length
    @statements.length
  end

  def add(statement,code,title,filename,statement_number)
    if restatement = @statements.detect{_1.to_s==statement}
      case restatement.type
      when 'D','X','P','T','C','R'
        @heap.add restatement
      else
        raise 'restatement'
      end
      code,_ = restatement.code
      title ||= restatement.title
      return code, title
    end
    statement = Statement.new(statement,code,title,filename,statement_number,self)
    @statements.push statement
    case statement.type
    when 'A','I','E','M'
      @symbols.define! statement
    when 'D','X'
      @symbols.define! statement
      @heap.add statement
    when 'P','T','C','R'
      @heap.add statement
    end
    return statement.code, statement.title
  end
end
end
