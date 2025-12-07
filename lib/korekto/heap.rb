# frozen_string_literal: true

module Korekto
  # Heap supports Korekto proof checking by maintaining a fixed-size list of
  # the most recent statements (newest first). It yields pairs in order of
  # increasing (i² + j²) to favor recent statements, reducing look-back and
  # search scope for verification.
  class Heap
    COMBOS_FOR = Hash.new do |hash, limit|
      hash[limit] = (0...limit).to_a
                               .combination(2)
                               .flat_map { |i, j| [[i, j], [j, i]] }
                               .sort_by { |i, j| (i * i) + (j * j) }
                               .freeze
    end
    private_constant :COMBOS_FOR

    def initialize(limit)
      @limit = limit
      @a = []
      @combos = COMBOS_FOR[@limit]
    end

    def to_a = @a
    def antecedent = @a[0].to_s

    def add(statement)
      @a.delete statement
      @a.unshift statement
      @a.pop if @a.length > @limit
    end

    def combos
      @combos.each do |i, j|
        next if [i, j].max >= @a.length

        yield(@a[i], @a[j])
      end
    end

    def each = @a.each { yield it }
  end
end
