# frozen_string_literal: true

require 'byebug'

class Gameboy
  attr_accessor :acc, :called_indexes, :instruction_list

  def initialize(instruction_list)
    @instruction_list = instruction_list
    @acc = 0
    @called_indexes = []
  end

  def func(list, index)
    return if called_indexes.size == instruction_list.size
    return if called_indexes.include? index

    called_indexes << index

    instruction, steps = list[index]

    return func(list, index + steps) if instruction == 'jmp'

    @acc += steps if instruction == 'acc'
    func(list, index + 1)
  end

  def call
    func(instruction_list, 0)
    [called_indexes, acc]
  end
end

input = File.read('./input.txt').split("\n").map(&:split)
list = input.map { |instruction, steps| [instruction, steps.to_i] }

indexes, = Gameboy.new(list).call

indexes.each do |index|
  next if list[index].first == 'acc'

  ins, steps = list[index]
  instruction = ins == 'nop' ? 'jmp' : 'nop'

  new_list = list.dup
  new_list[index] = [instruction, steps]

  called_indexes, acc = Gameboy.new(new_list).call
  break puts acc if called_indexes.size == list.size
end
