require 'byebug'

input = File.read('./input.txt').split("\n")

buses = input[1].split(',').map.with_index { |bus, index| [bus.to_i, index] }.sort.reverse

buses.reject! { |bus, _index| bus.zero? }

def find_time(bus, delay, cycle)
  (bus * cycle) - delay
end

found = []
first_bus = buses.shift
found << first_bus[0]
first_time = find_time(first_bus[0], first_bus[1], 0)
inc = 1
new_inc = nil
loop do
  if new_inc
    first_time += new_inc
  else
    first_time = find_time(first_bus[0], first_bus[1], inc)
  end

  next_lcm = buses.find do |bus, delay|
    cycle = (first_time / bus)
    current_time = 0
    loop do
      current_time = find_time(bus, delay, cycle)

      break if current_time >= first_time

      cycle += 1
    end

    current_time == first_time
  end

  if next_lcm
    found << buses.delete(next_lcm)[0]
    new_inc = found.reduce(&:lcm)

    break puts first_time if buses.size.zero?
  end

  inc += 1
end
