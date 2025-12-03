# frozen_string_literal: true

module Korekto
  # Heap supports Korekto proof checking by maintaining a fixed-size list of
  # the most recent statements (newest first). It yields pairs in order of
  # increasing (i² + j²) to favor recent statements, reducing look-back and
  # search scope for verification.
  class Heap
    def initialize(limit)
      @limit = limit
      @a = []
      @combos = build_combos
    end

    def to_a
      @a
    end

    def add(statement)
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

    private

    def build_combos
      (0...@limit)
        .to_a
        .combination(2)
        .sort { |ij, kl| (ij[0]**2) + (ij[1]**2) <=> (kl[0]**2) + (kl[1]**2) }
        .flat_map { |i, j| [[i, j], [j, i]] }
    end
  end
end
