require 'byebug'

input = File.read('./input.txt').split("\n")

time = input[0].to_i
buses = input[1].split(',').map(&:to_i) - [0]

a = buses.map { |bus| ((time / bus) * bus) - time + bus }

puts buses[a.find_index(a.min)] * a.min
