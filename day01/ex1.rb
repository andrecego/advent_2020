input = File.open('input.txt').read

array = input.split("\n").map(&:to_i)

cand_number = 0

while array.length
  cand_number = array.shift

  break if array.include?(2020 - cand_number)
end

puts cand_number

puts cand_number * (2020 - cand_number)
