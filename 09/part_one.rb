require_relative 'helper'
require_relative 'game'

FILENAME = "input.txt"

game_defs = read_file(FILENAME)
play_index = 0

# test input has multiple game defs, and they have high scores in the file so we can check
game = Game.new(game_defs[play_index])

puts game_defs[play_index].to_s
game.play
puts game.winner
