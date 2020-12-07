# frozen_string_literal: true

input = File.open('./input.txt').read

list = input.split("\n").map { |i| i.split(' ') }

passwords = list.map do |range, letter, password|
  range = Range.new(*range.split('-').map(&:to_i))
  letter = letter[0]

  range.include?(password.count(letter))
end

puts passwords.count(true)
