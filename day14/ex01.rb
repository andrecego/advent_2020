require 'byebug'

input = File.read('./input').split('mask = ').map { |i| i.split("\n") }
input.shift

mem_array = []
input.each do |inp|
  mask = inp.shift

  pos_num = inp.map { |num| num.scan(/\[(\d*)\].*\= (\d*)/)[0].map(&:to_i) }

  and_mask = mask.tr('X', '1').to_i(2)
  or_mask = mask.tr('X', '0').to_i(2)

  pos_num.each do |pos, num|
    mem_array[pos] = (num & and_mask) | or_mask
  end
end

puts mem_array.compact.sum
