input = File.read('./input.txt')

list = input.split("\n\n").map { |entry| entry.split("\n") }

list.map! do |group|
  group.map { |person| person.split('') }.reduce(&:&).size
end

puts list.reduce(&:+)
