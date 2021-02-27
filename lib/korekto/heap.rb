module Korekto
class Heap
  def initialize(limit)
    @limit = limit
    @combos = (0...limit).to_a.combination(2)
      .sort{|ij, kl| ij[0]**2 + ij[1]**2 <=> kl[0]**2 + kl[1]**2}
      .map{|i, j| [[i,j], [j,i]]}
      .inject([]){|a, ij_kl| a<<ij_kl[0]; a<<ij_kl[1]}
    @a = []
  end

  def add(s)
    @a.unshift s
    @a.pop if @a.length > @limit
  end

  def combos
    @combos.each do |i,j|
      next if [i,j].max >= @a.length
      yield(@a[i], @a[j])
    end
  end

  def each = @a.each{yield _1}
end
end
