require 'benchmark'

s1, s2 = nil, nil

puts Benchmark.measure {
  s1 = Array.new(101, Array.new(201, Array.new(201, [])))
}
puts Benchmark.measure {
  s2 = (0..100).map {
    (0..200).map {
      (0..200).map { [] }
    }
  }
}

puts s1 == s2