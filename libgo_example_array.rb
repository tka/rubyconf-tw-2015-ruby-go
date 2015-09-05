require 'ffi'
require 'benchmark'
require 'securerandom'
module Go
  extend FFI::Library
  ffi_lib "./libgo_example_array.so"

  attach_function :sum, [ :pointer, :long_long ], :long_long
end

def sum_by_go(nums)
  pointer = FFI::MemoryPointer.new :long_long, nums.length
  pointer.write_array_of_long_long(nums)
  Go.sum(pointer, nums.length)
end

source = Array.new(100){ SecureRandom.random_number(1000)}
runs = 100000
Benchmark.bmbm do |x|
  x.report("go"){ runs.times{ sum_by_go(source)}}
  x.report("ruby"){ runs.times{ source.inject(0, :+) }}
end
