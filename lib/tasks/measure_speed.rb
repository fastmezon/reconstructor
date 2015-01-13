require_relative '../reconstructor'
require 'benchmark'
Benchmark.bm do |x|
  x.report do
    N = 64**3
    N.times do
      CoefCalc.calc(1,1,1,1,1,1)
    end
  end
end
