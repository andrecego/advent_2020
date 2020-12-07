input = File.read('./input.txt')

list = input.split("\n\n").map do |str|
  str.split(/ |\n/).map { |p| p.split(':') }.to_h
end

required = %w[byr iyr eyr hgt hcl ecl pid]
list.map! { |obj| (required - obj.keys).empty? }

puts list.count(true)
