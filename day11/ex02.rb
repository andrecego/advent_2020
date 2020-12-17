require 'byebug'

input = File.read('./input.txt').split("\n").map { |e| e.split('') }

class FerrySeats
  attr_accessor :list
  def initialize(list)
    @list = list
  end

  def call
    list.map.with_index do |row, row_index|
      row.map.with_index do |_column, column_index|
        Seat.new(list, row_index, column_index).new_seat
      end
    end
  end
end

class Seat
  attr_accessor :list, :row_index, :col_index
  def initialize(list, row_index, col_index)
    @list = list
    @row_index = row_index
    @col_index = col_index
  end

  def new_seat
    current_seat = list[row_index][col_index]
    return current_seat if current_seat == '.'

    seatables = directions.values.map { |row, col| look_for_seat(row, col) }.compact
    occupied_seats = seatables.map { |seat| seat == '#' }

    return '#' if occupied_seats.all?(false)
    return 'L' if occupied_seats.count(true) >= 5

    current_seat
  end

  private

  def directions
    {
      north_west: [-1, -1],
      north: [-1, 0],
      north_east: [-1, 1],
      west: [0, -1],
      east: [0, 1],
      south_west: [1, -1],
      south: [1, 0],
      south_east: [1, 1]
    }
  end

  def look_for_seat(row, col)
    find_row = row_index + row
    find_col = col_index + col

    return nil if find_row.negative?
    return nil if find_col.negative?

    seat = list.at(find_row)&.at(find_col)
    return seat if seat != '.'

    new_row = if row.zero?
                0
              else
                row.negative? ? row.pred : row.next
              end

    new_col = if col.zero?
                0
              else
                col.negative? ? col.pred : col.next
              end

    look_for_seat(new_row, new_col)
  end
end

loop do
  new_input = FerrySeats.new(input).call

  break puts new_input.flatten.count('#') if new_input == input

  input = new_input.dup
end
