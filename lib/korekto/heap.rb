class Korekto
  class Heap
    def initialize(limit)
      @limit = limit
      @combos = (0...limit).to_a.combination(2)
        .sort{|ij, kl| ij[0]**2 + ij[1]**2 <=> kl[0]**2 + kl[1]**2}
        .map{|i, j| [[i,j], [j,i]]}
        .inject([]){|a, ij_kl| a<<ij_kl[0]; a<<ij_kl[1]}
      @a = []
    end

    def to_a
      @a
    end

    def add(s)
      @a.unshift s
      @a.pop if @a.length > @limit
    end

    def combos
      @combos.each{|i,j| yield(@a[i], @a[j])}
    end
  end
end
# Requires:
# `ruby`
