require 'byebug'
require 'prime'
a = File.new('./input.txt').readlines.map(&:to_i).sort
x = (a.count - a.max) / 2
puts "Part 1: #{(x + a.count) * (1 - x)}"

c = [nil, nil, nil, 1]
a.each { |i| c[i + 3] = c[i..i + 2].compact.sum }
puts "Part 2: #{c.last}"

p c.compact.uniq.map { |n| Prime.prime_division(n) }
