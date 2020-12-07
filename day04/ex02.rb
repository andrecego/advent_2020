input = File.read('./input.txt')

list = input.split("\n\n").map do |str|
  str.split(/ |\n/).map { |p| p.split(':') }.to_h
end

def valid?(field, value)
  case field
  when 'byr'
    year_valid?(value, 1920..2002)
  when 'iyr'
    year_valid?(value, 2010..2020)
  when 'eyr'
    year_valid?(value, 2020..2030)
  when 'hgt'
    height_valid?(value)
  when 'hcl'
    hex_valid?(value)
  when 'ecl'
    eye_color_valid?(value)
  when 'pid'
    pass_id_valid?(value)
  when 'cid'
    true
  else
    false
  end
end

def year_valid?(value, range)
  return false if value.size != 4

  range.include? value.to_i
end

def height_valid?(value)
  matcher = value.match(/^(\d*)(in|cm)$/)
  return false unless matcher

  range_in = 59..76
  range_cm = 150..193

  _, height, unit = *matcher
  return range_in.include? height.to_i if unit == 'in'
  return range_cm.include? height.to_i if unit == 'cm'

  false
end

def hex_valid?(value)
  value.match?(/^#[\dabcdef]{6}$/)
end

def eye_color_valid?(value)
  %w[amb blu brn gry grn hzl oth].include?(value)
end

def pass_id_valid?(value)
  value.match?(/^\d{9}$/)
end

required = %w[byr iyr eyr hgt hcl ecl pid]
list.map! do |obj|
  next false if (required - obj.keys).any?

  obj.all? { |key, value| valid?(key, value) }
end

puts list.count(true)
