require 'ffi'
require 'benchmark'

GC::Profiler.enable
module Go
  extend FFI::Library
  ffi_lib "./libgo_example_gc.so"
  attach_function :printTime, [ :string ], :void, :blocking=>false
end

def start_tick(tick_prefix)
  Go.printTime(tick_prefix)
end

start_tick("GC TEST PREFIX")
sleep(1)

# create garbage
20000.times{|i| "i"*i }

puts "===== GC.start ====="
GC.start

sleep(1)

puts GC::Profiler.report
