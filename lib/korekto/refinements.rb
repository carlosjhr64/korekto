module Korekto
module Refinements
  refine ::String do
    def balanced?(g)
      chars.select{|c| g.include?(c)}
      .map{|c| g.index(c).divmod(2)}
      .inject([]) do |a,km|
        k,m = *km
        m.zero? ? a<<k : k==a.last ? a[0..-2] : a<<k
      end
      .empty?
    end
    def ltight?(*c)  = c.all?{|c| !include?(' '+c)}
    def rtight?(*c)  = c.all?{|c| !include?(c+' ')}
    def tight?(*c)   = c.all?{|c| ltight?(c) && rtight?(c)}
  end
end
end
