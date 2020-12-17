require 'byebug'

input = File.read('./input.txt').split("\n").map(&:to_i)

sorted = input.sort
joltz = [0] + sorted + [sorted[-1] + 3]

@count = 0

def quantos_tem(list, start_index)
  @count += 1
  list.each_index do |i|
    index = start_index + i
    next if index.zero?
    next if index >= list.size - 1

    next unless list[index + 1] - list[index - 1] <= 3

    quantos_tem(list.dup.tap { |l| l.delete_at(index) }, index)
  end
end

tribonnaci(joltz, 0)

puts 'TBD'
