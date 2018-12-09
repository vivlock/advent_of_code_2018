require_relative 'helper'
require_relative 'guard'

#filename = "small_input.txt"
filename = "input.txt"

guards = Hash.new
updates = read_file(filename)

cur_guard = 0
updates.each do |update|
  if update[:new_shift_id] != 0
    cur_guard = update[:new_shift_id]
    if !guards.has_key?(cur_guard)
      guards[cur_guard] = Guard.new cur_guard
    end
  elsif update[:wakes]
    guards[cur_guard].wake(update[:time])
  elsif update[:sleeps]
    guards[cur_guard].sleep(update[:time])
  end
end

puts "Part One"
sleepiest_guard = guards.max_by { |k, v| v.time_asleep }
puts "The sleepiest guard is #{sleepiest_guard[0]}, who slept for #{sleepiest_guard[1].time_asleep} minutes, and the most at minute #{sleepiest_guard[1].sleepiest_minute}"
puts "The value for the advent is #{sleepiest_guard[0] * sleepiest_guard[1].sleepiest_minute}"

#I already mostly solved part 2 in part 1, so just appending it
puts "Part Two"
most_specific_guard = guards.max_by { |k, v| v.sleepiest_minute_minutes }
puts "The sleepiest minute was held by #{most_specific_guard[0]}, who was asleep at minute #{most_specific_guard[1].sleepiest_minute} #{most_specific_guard[1].sleepiest_minute_minutes} times"
puts "The value for the advent is #{most_specific_guard[0] * most_specific_guard[1].sleepiest_minute}"
