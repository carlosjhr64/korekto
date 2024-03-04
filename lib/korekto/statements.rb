module Korekto
class Statements
  attr_reader :heap,:symbols,:syntax,:handwaves,:last

  def initialize
    @statements = []
    @heap = Heap.new Korekto.heap
    @symbols = Symbols.new
    @syntax = Syntax.new
    @handwaves = Handwaves.new(self)
    @last = nil
  end

  def type(c)  = @statements.select{_1.type==c}
  def length   = @statements.length
  def patterns = @statements.select(&:pattern?).each{yield _1}

  def add(statement,code,title,filename)
    c = code[0]; w = c=='W'
    @syntax.check(statement) unless statement[0]=='/' &&
                                    statement[-1]=='/' &&
                                    %w[A L M E I].include?(c)
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
    @last=Statement.new(statement,code,title,filename,statement_number,self)
    @statements.push @last
    @symbols.define! @last if 'AIEMLDXS'.include?(@last.type)
    @heap.add @last if 'DXSPTCRH'.include?(@last.type)
    [@last.code, @last.title]
  end
end
end
