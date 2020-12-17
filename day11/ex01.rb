require 'byebug'

input = File.read('./input.txt').split("\n").map { |e| e.split('') }

def cond_index(list, y, x)
  return nil if x.negative?
  return nil if y.negative?

  list.at(x)&.at(y)
end

new_array = []
loop do
  new_array = input.map.with_index do |row, x|
    row.map.with_index do |el, y|
      cond_array = []
      cond_array = [cond_index(input, y - 1, x - 1),
                    cond_index(input, y - 1, x),
                    cond_index(input, y - 1, x + 1),
                    cond_index(input, y, x - 1),
                    cond_index(input, y, x + 1),
                    cond_index(input, y + 1, x - 1),
                    cond_index(input, y + 1, x),
                    cond_index(input, y + 1, x + 1)]

      cond_array.compact!

      cond_array.map! { |test_seat| test_seat.match?(/[L\.]/) }

      case el
      when '.'
        next '.'
      when 'L'
        next '#' if cond_array.all?
      when '#'
        next 'L' if cond_array.count(false) >= 4
      end

      el
    end
  end
  File.open('./output.txt', 'a') do |f|
    new_array.each_slice(10) { |slice| f.write(slice); f.write("\n") }
    f.write("\n")
  end
  break if input == new_array

  input = new_array.dup
end

puts new_array.flatten.count('#')
