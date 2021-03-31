module Korekto
class Statements
  attr_reader :heap,:symbols,:syntax
  def initialize
    @statements = []
    @heap = Heap.new(13)
    @symbols = Symbols.new
    @syntax = Syntax.new
  end

  def type(c) = @statements.select{_1.type==c}
  def length = @statements.length

  def add(statement,code,title,filename)
    c = code[0]; w = c=='W'
    if restatement = @statements.detect{(w or _1.type==c) and _1.to_s==statement}
      case restatement.type
      when 'D','X','S','P','T','C','R'
        @heap.add restatement
      else
        raise Error, "restatement: #{restatement.code}"
      end
      code,_ = restatement.code
      title ||= restatement.title
      return code, title
    end
    statement_number = yield
    statement = Statement.new(statement,code,title,filename,statement_number,self)
    @statements.push statement
    case statement.type
    when 'A','I','E','M','L'
      @symbols.define! statement
    when 'D','X','S'
      @symbols.define! statement
      @heap.add statement
    when 'P','T','C','R'
      @heap.add statement
    end
    return statement.code, statement.title
  end
end
end
