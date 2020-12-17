require 'byebug'

rules, my_ticket, nearby_tickets = File.read('./input').split("\n\n")

rules = rules.split("\n").map do |rule|
  a = rule.scan(/(^.*): (\d*-\d*) or (\d*-\d*)/).flatten

  first_range = Range.new(*a[1].split('-').map(&:to_i))
  last_range = Range.new(*a[2].split('-').map(&:to_i))

  [first_range, last_range]
end.flatten

nearby_tickets = nearby_tickets.split("\n")
nearby_tickets.shift
nearby_tickets.map! { |nb| nb.split(',').map(&:to_i) }
error_rate = 0

nearby_tickets.flatten.each do |number|
  valid = rules.any? { |rule| rule.include? number }
  error_rate += number unless valid
end

puts error_rate
