# ref. https://github.com/gettalong/kramdown/blob/master/benchmark/benchmark.rb
#
require 'benchmark'
require 'stringio'

require "github/markdown"
require 'kramdown'
require 'redcarpet'
require "open-uri"
require "ffi"

module Go
  extend FFI::Library
  ffi_lib "./libgo_example_gfm.so"
  attach_function :gfm, [ :string ], :string
  attach_function :md, [ :string ], :string
end


RUNS=200

puts "Running tests on #{Time.now.strftime("%Y-%m-%d")} under #{RUBY_DESCRIPTION}"

data = open('https://raw.githubusercontent.com/jgm/peg-markdown/master/MarkdownTest_1.0.3/Tests/Markdown%20Documentation%20-%20Syntax.text'){|f| f.read}

puts "Test using file https://raw.githubusercontent.com/gettalong/kramdown/master/benchmark/mdbasics.text and #{RUNS} runs"
results = Benchmark.bmbm do |b|
  b.report("kramdown #{Kramdown::VERSION}") { RUNS.times { Kramdown::Document.new(data, input:'GFM' ).to_html } }
  b.report("golang-blackfriday") { RUNS.times { Go.md(data) } }
  b.report("golang-gfm") { RUNS.times { Go.gfm(data) } }
  b.report("redcarpet #{Redcarpet::VERSION}") { RUNS.times { Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(data) } }
  b.report("github-markdown"){ RUNS.times{ GitHub::Markdown.render(data) } }
end

puts
puts "Real time of X divided by real time of kramdown"
kd = results.shift.real
%w[golang-blackfriday golang-gfm redcarpet  github-markdown].each do |name|
  puts name.ljust(19) << (results.shift.real/kd).round(4).to_s
end
