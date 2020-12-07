input = File.read('./input.txt').split("\n")

input.map! do |binary|
  row = binary[0..6].gsub('B', '1').gsub('F', '0').to_i(2)
  col = binary[-3..-1].gsub('R', '1').gsub('L', '0').to_i(2)

  (row * 8) + col
end

puts input.max
