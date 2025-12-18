# frozen_string_literal: true

module Korekto
  # Heap supports Korekto proof checking by maintaining a fixed-size list of
  # the most recent statements (newest first). It yields pairs in order of
  # increasing (i² + j²) to favor recent statements, reducing look-back and
  # search scope for verification.
  # :reek:UncommunicativeVariableName { accept: [ i, j ] }
  class Heap
    include Enumerable

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
      @heap = []
      @combos = COMBOS_FOR[@limit]
    end

    def swap(tmp = [])
      @heap, tmp = tmp, @heap
      tmp
    end

    def follows(nlc)
      @heap[0..nlc].reverse
    end

    def antecedent = @heap[0].to_s

    def add(statement)
      @heap.delete statement
      @heap.unshift statement
      @heap.pop if @heap.length > @limit
    end

    def combos
      @combos.each do |i, j|
        next if [i, j].max >= @heap.length

        yield(@heap[i], @heap[j])
      end
    end

    def each = @heap.each { yield it }
  end
end
