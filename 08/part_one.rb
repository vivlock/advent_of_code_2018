require_relative 'helper'

#FILENAME = "sample_input.txt"
FILENAME = "input.txt"

node = parse_node(read_file(FILENAME))
sum = sum_metadata(node)

puts "I dunno lol it's #{sum}"
