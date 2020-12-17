require 'byebug'

input = File.read('./input.txt').split("\n")

class Ferry
  attr_accessor :commands, :current_direction, :position
  def initialize
    @current_direction = directions[:E]
    @position = [0, 0]
  end

  def call(command)
    instruction, amount = command
    return rotate(instruction, amount) if instruction.match?(/[LR]/)
    return forward(amount) if instruction == 'F'

    drift(instruction, amount)
  end

  def forward(amount)
    move(current_direction, amount)
  end

  def move(direction, amount)
    to_move = direction.map { |num| num * amount }
    @position = [position, to_move].transpose.map(&:sum)
  end

  def rotate(instruction, amount)
    quarter_rotations = amount / 90
    clockwise = instruction == 'R'

    current_index = directions.find_index { |_key, value| value == current_direction }
    new_rotation = clockwise ? current_index + quarter_rotations - 4 : current_index - quarter_rotations

    @current_direction = directions.values[new_rotation]
  end

  def drift(instruction, amount)
    move(directions[instruction.to_sym], amount)
  end

  def directions
    {
      N: [1, 0],
      E: [0, 1],
      S: [-1, 0],
      W: [0, -1]
    }
  end
end

list = input.map { |line| [line[0], line[1..-1].to_i] }

ferry = Ferry.new

list.each { |command| ferry.call(command) }

puts ferry.position.map(&:abs).sum
