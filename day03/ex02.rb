# frozen_string_literal: true

input = File.read('./input.txt')
LIST = input.split("\n")
MAX_SIZE = LIST[0].size

def bump(inc_x, inc_y)
  x = inc_x
  y = inc_y
  count = 0

  while LIST.size > y
    count += 1 if LIST[y][x] == '#'

    x += inc_x
    y += inc_y

    x -= MAX_SIZE if x >= MAX_SIZE
  end

  count
end

puts [bump(1, 1), bump(3, 1), bump(5, 1), bump(7, 1), bump(1, 2)].reduce(&:*)
