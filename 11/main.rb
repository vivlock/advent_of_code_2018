# For grid sn 42, largest 3x3 starts at 21,61
# For grid sn 18, largest 3x3 starts at 33,45

# Part 2:
# For grid serial number 18, the largest total square (with a total power of 113) is 16x16 and has a top-left corner of 90,269, so its identifier is 90,269,16.
# For grid serial number 42, the largest total square (with a total power of 119) is 12x12 and has a top-left corner of 232,251, so its identifier is 232,251,12.

# Real input: grid serial number 7672

require_relative 'helper'
grid = Hash.new
GRID_SN = 18

highest_power = 0
highest_power_block = nil

def get_block_power(x, y, block_size, grid)
  power = 0
  prev_size = block_size - 1
  if prev_size > 0
    if !grid[c(x, y)].block_power(prev_size).nil?
      # we've already calculated the previous block, use that to calc the next one
      power += grid[c(x, y)].block_power(prev_size)
      mod = block_size - 1
      for i in 0..(mod - 1)
        power += grid[c(x + mod, y + i)].power
        power += grid[c(x + i, y + mod)].power
      end
      power += grid[c(x + mod, y + mod)].power
      grid[c(x, y)].set_block_power(block_size, power)
      return power
    end
  end

  for x_add in 0..(block_size - 1)
    for y_add in 0..(block_size - 1)
      power += grid[c(x + x_add, y + y_add)].power
    end
  end
  return power
end

def get_highest_for_block_size(size, grid)
  highest = { power: 0, block: nil, size: size }
  upper_cell_limit = 300 - (size - 1)
  for x in 1..upper_cell_limit
    for y in 1..upper_cell_limit
      power = get_block_power(x, y, size, grid)
      if power > highest[:power]
        highest[:power] = power
        highest[:block] = grid[c(x, y)]
      end
    end
  end
  return highest
end

def get_highest_for_point(x, y, grid)
  highest = { power: 0, size: 0, block: grid[c(x,y)] }
  for size in 1..300
    next if x + (size - 1) > 300
    next if y + (size - 1) > 300
    power = get_block_power(x, y, size, grid)
    if power > highest[:power]
      highest[:power] = power
      highest[:size] = size
    end
  end
  return highest
end

# (•_•)  ( •_•)>⌐□-□  (⌐□_□)
def c(x, y)
  return "#{x},#{y}"
end

# initialize the grid
# this hash "grid" is a monstrosity and I'm rather proud of it.
for x in 1..300
  for y in 1..300
    if grid[c(x, y)].nil?
      grid[c(x, y)] = FuelCell.new(x, y, GRID_SN)
    end
  end
end

# calculate power for each 3x3
# for x in 1..298
#   for y in 1..298
#     power = get_block_power(x, y, 3, grid)
#     if power > highest_power
#       highest_power = power
#       highest_power_block = grid[c(x, y)]
#     end
#   end
# end

highest = { power: 0, block: nil, size: 1 }
# for size in 1..300
#   block_highest = get_highest_for_block_size(size, grid)
#   puts "highest power for #{size} is #{block_highest[:power]}"
#   if block_highest[:power] > highest[:power]
#     highest = block_highest
#   end
# end
for x in 1..300
  for y in 1..300
    highest_at_point = get_highest_for_point(x, y, grid)
    puts "Highest at #{c(x,y)} is #{highest_at_point[:power]} for block #{highest_at_point[:size]}"
    if highest[:power] < highest_at_point[:power]
      highest = highest_at_point
    end
  end
end

puts "Highest power is #{highest[:power]} at #{highest[:block].c} and block size #{highest[:size]}"

# grid.each do |key, value|
#   puts "#{key}: #{value}"
# end

# puts "Highest power is #{highest_power} at block #{highest_power_block.c}"
