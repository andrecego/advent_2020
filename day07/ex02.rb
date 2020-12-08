input = File.read('./input.txt').split("\n")

LIST = input.each_with_object({}) do |bags, acc|
  first_bag = bags.match(/(.*?) bags? contain/)[1]
  other_bags = bags.scan(/(\d+ .*?) bags?. ?/)

  bag_space = other_bags.each_with_object({}) do |single_bag, acc2|
    number, bag = single_bag.join.scan(/(\d*) (.*)/).flatten
    acc2[bag] = number.to_i
  end
  bag_space = { 'unit' => 1 } if bag_space.empty?

  acc[first_bag] = bag_space
end

while LIST.any? { |_key, value| value.keys != ['unit'] }
  unit_bags = LIST.select { |_key, value| value.keys.include?('unit') }

  unit_bags.each do |bag_name, bag_qty|
    next unless bag_qty.keys == ['unit']

    unit_bags = LIST.select { |_key, values| values.keys.include? bag_name }
    unit_bags.each do |bn, _bag_list|
      LIST[bn]['unit'] ||= 0
      LIST[bn]['unit'] += LIST[bn][bag_name] * bag_qty['unit']
      LIST[bn].delete(bag_name)
      LIST[bn]['unit'] += 1 if LIST[bn].keys == ['unit']
    end
  end
end

puts LIST['shiny gold']['unit'] - 1
