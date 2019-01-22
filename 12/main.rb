require_relative 'helper'

FILENAME = "sinput.txt"

game_state = read_file(FILENAME)
game_state.output_state

# while(input = gets)
#   game_state.tick
#   game_state.output_state
# end

while(game_state.gen < 20)
  game_state.tick
  game_state.output_state
end

puts "Generation #{game_state.gen}, Total: #{game_state.get_total}"
