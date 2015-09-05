require 'ffi'
require 'benchmark'
require 'http_accept_language/parser'

module LibGo
  class GoString < FFI::Struct
    layout :p, :pointer,
      :n, :int
  end
  extend FFI::Library
  ffi_lib './libgo_example_3.so'
  attach_function :preferredLanguageFrom, [GoString.by_ref], GoString.by_ref
  attach_function :preferredLanguageFromUseCString, [:string], :string
end

@lang = "en;q=0.9,zh;q=0.8,en-US;q=0.6,en-GB;q=0.2"
@availables = %w(en ja zh-CN zh-TW )

def use_go
  x = LibGo::GoString.new
  x[:p] = FFI::MemoryPointer.from_string(@lang)
  x[:n] = @lang.length
  result =  LibGo.preferredLanguageFrom( x )
  result[:p].get_string(0, result[:n])
end

def use_go_cstring
  LibGo.preferredLanguageFromUseCString( @lang )
end

def use_ruby
  parser = HttpAcceptLanguage::Parser.new(@lang)
  parser.preferred_language_from( @availables )
end

n=100000

Benchmark.bm do |x|
  x.report("GoString"){ n.times{ use_go() }}
  x.report("CString"){ n.times{ use_go_cstring() }}
  x.report("Ruby"){ n.times{ use_ruby() }}
end
