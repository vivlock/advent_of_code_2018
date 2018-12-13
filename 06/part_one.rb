require_relative 'do_the_thing'

doTheThing = DoTheThing.new
biggest = doTheThing.find_largest_finite_area

puts "The biggest area is #{biggest.area} at (#{biggest.x}, #{biggest.y})"
