require 'ffi'
require 'fiddle'
require 'benchmark'

LIB_PATH= "./libgo_example_1.so"

module FFILib
  extend FFI::Library
  ffi_lib LIB_PATH
  attach_function :add, [ :int, :int ], :int
end


lib = Fiddle.dlopen(LIB_PATH)

fiddle_add = Fiddle::Function.new(
  lib['add'],  [Fiddle::TYPE_INT, Fiddle::TYPE_INT],  Fiddle::TYPE_INT
)

n=1000000
Benchmark.bmbm(10) do |x|
  x.report("fiddle") { n.times{ fiddle_add.call(1,1) }}
  x.report("ffi"){ n.times{ FFILib.add(1,1)  }}
end
