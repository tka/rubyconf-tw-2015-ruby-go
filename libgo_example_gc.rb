require 'ffi'
require 'benchmark'

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

puts "create garbage\n"
# create garbage
20000.times{|i| "i"*i }

sleep(1)
