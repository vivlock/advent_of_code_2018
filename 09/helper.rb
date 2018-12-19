# this one's input is different from the previous ones
# an input is one line -- sample_input.txt has 5 lines we can test with
# real input.txt has only one line
def read_file(filename)
  inputs = Array.new

  fh = open FILENAME
  while (line = fh.gets)
    inputs.push(parse_input(line))
  end
  fh.close

  return inputs
end

def parse_input(line)
  #X players; last marble is worth Y points: high score is Z
  pieces = line.split(' ')
  players = pieces[0]
  last_marble = pieces[6]
  # the real input doesn't have the high score, it's just so we can check the program
  if pieces.length > 8
    high_score = pieces[-1]
  end
  return GameDef.new(players, last_marble, high_score)
end

# just a little container for the input info -- optionally takes high score so we can check against it on sample data
class GameDef
  def initialize(num_players, last_marble, high_score = -1)
    @num_players = num_players.to_i
    @last_marble = last_marble.to_i
    @high_score = high_score.to_i
  end
  def to_s
    return "#{@num_players} players; last marble is worth #{@last_marble} points"
  end
  def players
    return @num_players
  end
  def last_marble
    return @last_marble
  end
  def high_score
    return @high_score
  end
end
