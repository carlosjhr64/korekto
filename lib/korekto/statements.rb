module Korekto
class Statements
  attr_reader :heap,:symbols,:syntax

  def initialize
    @statements = []
    @heap = Heap.new Korekto.heap
    @symbols = Symbols.new
    @syntax = Syntax.new
  end

  def type(c) = @statements.select{_1.type==c}
  def length = @statements.length

  def add(statement,code,title,filename)
    c = code[0]; w = c=='W'
    if (restatement=@statements.detect{(w || _1.type==c) && _1.to_s==statement})
      unless 'DXSPTCR'.include?(restatement.type)
        # Only allow heap-able statements to be restated.
        raise Error, "restatement: #{restatement.code}"
      end
      @heap.add restatement
      code, = restatement.code
      title ||= restatement.title
      return code, title
    end
    statement_number = yield
    statement=Statement.new(statement,code,title,filename,statement_number,self)
    @statements.push statement
    @symbols.define! statement if 'AIEMLDXS'.include?(statement.type)
    @heap.add statement if 'DXSPTCR'.include?(statement.type)
    [statement.code, statement.title]
  end
end
end
