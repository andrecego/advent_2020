input = File.read('./input.txt').split("\n")

LIST = input.each_with_object({}) do |bags, acc|
  first_bag = bags.match(/(.*?) bags? contain/)[1]
  other_bags = bags.scan(/(\d+ .*?) bags?. ?/)

  bag_space = other_bags.each_with_object({}) do |single_bag, acc2|
    number, bag = single_bag.join.scan(/(\d*) (.*)/).flatten
    acc2[bag] = number
  end
  acc[first_bag] = bag_space
end

def find_bag(bag_name)
  LIST.select { |_key, value| value.keys.include?(bag_name) }.keys
end

container = ['shiny gold']

counter = 0
while container.size != counter
  counter = container.size
  container.each do |bag|
    contained_bags = find_bag(bag)
    next if contained_bags.empty?

    container |= contained_bags
  end
end

puts counter - 1
