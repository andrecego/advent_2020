# frozen_string_literal: true

input = File.open('./input.txt').read

list = input.split("\n").map { |i| i.split(' ') }

passwords = list.map do |range, letter, password|
  pos1, pos2 = range.split('-').map(&:to_i)
  letter = letter[0]

  (password[pos1 - 1] == letter) ^ (password[pos2 - 1] == letter)
end

puts passwords.count(true)
