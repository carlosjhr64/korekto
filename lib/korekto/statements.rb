module Korekto
class Statements
  attr_reader :heap,:symbols,:syntax,:s2r
  def initialize
    @statements = []
    @heap = Heap.new(13)
    @symbols = Symbols.new
    @syntax = Syntax.new
    @s2r = S2R.new
  end

  def type(c)
    @statements.select{_1.type==c}
  end

  def length
    @statements.length
  end

  def add(statement, code, title)
    if restatement = @statements.detect{_1.to_s==statement}
      code,_ = restatement.code
      title ||= restatement.title
      return code, title
    end
    statement = Statement.new(statement, code, title, self)
    @statements.push statement
    @heap.add statement if statement.heap?
    @symbols.define! statement if statement.defines?
    return statement.code, statement.title
  end
end
end
