require 'ffi'
require 'benchmark'

module Go
  extend FFI::Library
  ffi_lib "./libgo_example_1.so"
  attach_function :add, [ :int, :int ], :int
end

n=1000000
Benchmark.bm do |x|
  x.report("golang") { n.times{ Go.add(1,1) }}
  x.report("ruby"){ n.times{ 1+1 }}
end
