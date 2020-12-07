# frozen_string_literal: true

input = File.open('./input.txt').read

list = input.split("\n")

list.shift

max_size = list[0].size

count = 0
arveres = list.map do |row|
  count += 3
  count -= max_size if count >= max_size

  row[count] == '#'
end

puts arveres.count(true)
