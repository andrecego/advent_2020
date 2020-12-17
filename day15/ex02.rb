require 'byebug'

input = '5,2,8,16,18,0,1'.split(',')

hash = input.each_with_index.each_with_object({}) do |(num, index), acc|
  acc[num.to_s] = index
end

last_number = -1
turn = 0
hash = {}
loop do
  if turn < input.size
    spoken_number = hash[input[turn]]
    last_number = spoken_number || 0
    hash[input[turn]] = turn
    next turn += 1
  end

  if hash[last_number.to_s].nil?
    hash[last_number.to_s] = turn
    last_number = 0
  else
    spoken = turn - hash[last_number.to_s]
    hash[last_number.to_s] = turn
    last_number = spoken
  end

  break puts last_number if turn == 30_000_000 - 2

  turn += 1
end
