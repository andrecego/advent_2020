input = File.open('input.txt').read

array = input.split("\n").map(&:to_i)

numbers = []

array.each do |num1|
  array.each do |num2|
    numbers = [num1, num2, 2020 - num1 - num2] if array.include?(2020 - num1 - num2)
  end
end

puts numbers.reduce(&:*)
