module Korekto
class Statements
  attr_reader :heap,:symbols,:syntax,:handwaves

  def initialize
    @statements = []
    @heap = Heap.new Korekto.heap
    @symbols = Symbols.new
    @syntax = Rules.new
    @handwaves = []
  end

  def type(c)  = @statements.select{_1.type==c}
  def length   = @statements.length
  def last     = @statements.last
  def patterns = @statements.select(&:pattern?).each{yield _1}

  def add(statement,code,title,filename)
    c = code[0]; w = c=='W'
    unless (statement[0]=='/' &&
            statement[-1]=='/' &&
            %w[A L M E I].include?(c)
           ) || (rule = @syntax.detect(statement, false)).nil?
      raise Error, "syntax: #{rule}"
    end
    if (restatement=@statements.detect{(w || _1.type==c) && _1.to_s==statement})
      unless 'DXSPTCRH'.include?(restatement.type)
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
    @heap.add statement if 'DXSPTCRH'.include?(statement.type)
    [statement.code, statement.title]
  end
end
end
