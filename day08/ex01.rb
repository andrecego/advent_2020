# frozen_string_literal: true

require 'byebug'

class Gameboy
  attr_accessor :acc, :called_indexes

  def initialize
    @acc = 0
    @called_indexes = []
  end

  def func(list, index)
    return if called_indexes.include? index

    called_indexes << index
    instruction, steps = list[index]
    return func(list, index + steps) if instruction == 'jmp'

    @acc += steps if instruction == 'acc'

    func(list, index + 1)
  end

  def call
    input = File.read('./input.txt').split("\n").map(&:split)
    instruction_list = input.map { |instruction, steps| [instruction, steps.to_i] }
    func(instruction_list, 0)
    acc
  end
end

puts Gameboy.new.call
