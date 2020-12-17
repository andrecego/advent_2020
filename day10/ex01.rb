require 'byebug'

input = File.read('./input.txt').split("\n").map(&:to_i)

sorted = input.sort

joltz = [0] + sorted + [sorted[-1] + 3]

joltz_diff = joltz[1..-1].zip(joltz).map { |x, y| x - y }

puts joltz_diff.count(1), joltz_diff.count(3)
