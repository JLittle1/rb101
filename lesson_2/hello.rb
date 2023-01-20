require 'pry'

Kernel.puts("hello world")
binding.pry
a = 0
b = 1
binding.pry
loop do
  c = a + b
  a = b
  b = c
  binding.pry
end