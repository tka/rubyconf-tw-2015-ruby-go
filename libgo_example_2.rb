require 'ffi'
require 'benchmark'

module LibGo
  extend FFI::Library
  ffi_lib './libgo_example_2.so'
  attach_function :fib, [:int], :int
end

def fib(i)
  return i if i < 2
  return fib(i-2)+fib(i-1)
end
LibGo.fib(1)
n=10000
Benchmark.bm(15) do |x|
  (2..14).step(2).each do |num|
    puts "-"*60
    x.report("fib #{num} golang "){ n.times{ LibGo.fib(num) }}
    x.report("fib #{num} ruby"){ n.times{ fib(num); }}
  end
end
