require_relative 'helper'

FILENAME = "sample_input.txt"

points = read_file(FILENAME)
grid = Grid.new(points)

output_2d_arr(grid.output)

while(input = gets)
  grid.tick
  output_2d_arr(grid.output)
  puts "#{grid.elapsed} seconds"
end
