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

puts Xmas.new(25).call
