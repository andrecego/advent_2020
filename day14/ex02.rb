require 'byebug'

input = File.read('./input').split('mask = ').map { |i| i.split("\n") }
input.shift

def binary_combinations(str)
  return str if str.count('X').zero?

  var = [str.sub(/X/, '0'), str.sub(/X/, '1')]
  var.map { |el| binary_combinations(el) }.flatten
end

def x_mask(mask, num)
  [mask.chars, num.chars].transpose.map do |ma, nu|
    next ma if %w[1 X].include? ma

    nu
  end.reduce(&:+)
end

mem_hash = {}
input.each do |inp|
  mask = inp.shift

  pos_num = inp.map { |num| num.scan(/\[(\d*)\].*\= (\d*)/)[0].map(&:to_i) }

  pos_num.each do |pos, num|
    mem_nums = binary_combinations(x_mask(mask, pos.to_s(2).rjust(36, '0'))).map { |bn| bn.to_i(2) }

    mem_nums.each do |mem_num|
      mem_hash[mem_num.to_s] = num
    end
  end
end

puts mem_hash.values.sum
