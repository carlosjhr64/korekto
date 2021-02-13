module Korekto
class Statements
  def initialize
    @h = {}
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

  def [](statement)
    @h[statement]
  end

  def add(statement, code, title)
    if code_title = @h[statement]
      # Restatement
      code,_ = code_title.split(' ', 2)
      title ||=_
      return code, title
    end
    statement = Statement.new(statement, code, title)
    statement,code,title = statement.statement,statement.code,statement.title
    code_title = (title)? "#{code} #{title}" : code
    @h[statement]=code_title
  end
end
end
