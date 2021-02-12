class Korekto
  class Statements
    def initialize
      @h = {}
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

    def [](s)
      @h[s]
    end

    def []=(s,c)
      @h[s]=c
    end

    def key?(s)
      @h.key?(s)
    end
  end
end
