require 'byebug'

class Xmas
  attr_accessor :range_index, :preamble_size, :input
  def initialize(size)
    @preamble_size = size
    @range_index = 0
    @input = File.read('./input.txt').split("\n").map(&:to_i)
  end

  def call
    find_unruly
  end

  private

  def find_unruly
    loop do
      next  @range_index += 1 if valid?

      break current_number
    end
  end

  def valid?
    current_preamble.any? { |num| (current_preamble - [num]).include? current_number - num }
  end

  def current_number
    input[preamble_size + range_index]
  end

  def current_preamble
    input[range_index..range_index + preamble_size - 1]
  end
end

class Decryptor
  attr_accessor :list, :number, :min_index, :max_index
  def initialize(list, number)
    @list = list
    @number = number
    @min_index = 0
    @max_index = 1
  end

  def call
    loop do
      sum = list[min_index..max_index].sum

      next @min_index += 1 if sum > number
      next @max_index += 1 if sum < number

      break
    end
    list[min_index..max_index].minmax
  end
end

minmax = Xmas.new(25).call

puts minmax.sum
