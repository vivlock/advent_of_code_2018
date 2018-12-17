require_relative 'helper'

#FILENAME = "sample_input.txt"
FILENAME = "input.txt"

node = parse_node(read_file(FILENAME))
sum = sum_metadata(node)
value = calculate_value(node)

puts "The sum of all metadata is #{sum}"

puts "The total node value is #{value}"
