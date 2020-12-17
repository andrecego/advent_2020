require 'byebug'

rules, my_ticket, nearby_tickets = File.read('./input').split("\n\n")

rules = rules.split("\n").map do |rule|
  rule_name, range1, range2 = rule.scan(/(^.*): (\d*-\d*) or (\d*-\d*)/).flatten

  first_range = Range.new(*range1.split('-').map(&:to_i))
  last_range = Range.new(*range2.split('-').map(&:to_i))

  [rule_name, first_range, last_range]
end

my_ticket = my_ticket.split("\n")[1].split(',').map(&:to_i)

flatten_rules = rules.map { |_descarte, a, b| [a, b] }.flatten

nearby_tickets = nearby_tickets.split("\n")
nearby_tickets.shift
nearby_tickets.map! { |nb| nb.split(',').map(&:to_i) }

valid_tickets = nearby_tickets.map do |numbers|
  valid = numbers.all? { |num| flatten_rules.any? { |rule| rule.include? num } }
  next unless valid

  numbers.map! do |num|
    rules.map do |rule, *ranges|
      rule if ranges.any? { |range| range.include? num }
    end
  end
end.compact

valid_fields = valid_tickets.transpose.map do |field|
  field.transpose.map do |rule_set|
    rule_set.all? ? rule_set[0] : nil
  end.compact
end

already_found = []
loop do
  found = valid_fields.find { |el| el.size == 1 && !already_found.include?(el) }
  already_found << found

  break unless found

  valid_fields.map! do |fields|
    next fields if fields.size == 1

    fields - found
  end
end

answer = valid_fields.map.with_index do |field, index|
  next unless field[0].match?(/^departure.*/)

  my_ticket[index]
end

puts answer.compact.reduce(&:*)
