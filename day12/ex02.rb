require 'byebug'

input = File.read('./input.txt').split("\n")

class Ferry
  attr_accessor :commands, :waypoint, :position
  def initialize
    @waypoint = [10, 1]
    @position = [0, 0]
  end

  def call(command)
    instruction, amount = command
    return rotate(instruction, amount) if instruction.match?(/[LR]/)
    return move(amount) if instruction == 'F'

    change_waypoint(instruction, amount)
  end

  def move(amount)
    to_move = waypoint.map { |num| num * amount }
    @position = [position, to_move].transpose.map(&:sum)
  end

  def rotate(instruction, amount)
    quarter_rotations = (amount / 90)
    turn = instruction == 'R' ? [1, -1] : [-1, 1]

    quarter_rotations.times do
      @waypoint = [waypoint.reverse, turn].transpose.map { |arr| arr.reduce(&:*) }
    end
  end

  def change_waypoint(instruction, amount)
    to_move = directions[instruction.to_sym].map { |num| num * amount }
    @waypoint = [waypoint, to_move].transpose.map(&:sum)
  end

  def directions
    {
      N: [0, 1],
      E: [1, 0],
      S: [0, -1],
      W: [-1, 0]
    }
  end
end

list = input.map { |line| [line[0], line[1..-1].to_i] }

ferry = Ferry.new

list.each { |command| ferry.call(command) }

puts ferry.position.map(&:abs).sum
