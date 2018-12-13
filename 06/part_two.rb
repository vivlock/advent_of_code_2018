require_relative 'do_the_thing'

doTheThing = DoTheThing.new
region = doTheThing.find_region_near_coords

puts "The region size is #{region.length}"
