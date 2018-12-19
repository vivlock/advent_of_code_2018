require_relative 'doubly_linked_list'
require_relative 'helper'

class Game
  def initialize(game_def)
    @num_players = game_def.players
    @last_marble = game_def.last_marble
    @high_score = game_def.high_score

    @current_marble = 1
    @current_player = 1

    @game_board = DoublyLinkedList.new(0)
    @players = Hash.new
    for i in 1..@num_players
      @players[i] = Player.new(i)
    end
  end

  def take_turn
    if(@current_marble % 23 == 0)
      @players[@current_player].add_score(@current_marble)
      @game_board.rotate_ccw(7)
      removed_marble = @game_board.delete_current
      @players[@current_player].add_score(removed_marble)
    else
      @game_board.rotate_cw(1)
      @game_board.add_right_node(@current_marble)
      @game_board.rotate_cw(1)
    end
    @current_marble += 1
    next_player
  end

  def next_player
    if @current_player == @num_players
      @current_player = 1
    else
      @current_player += 1
    end
  end

  def play
    while @current_marble <= @last_marble
      take_turn
    end
  end

  def winner
    winner = nil
    high_score = 0
    for i in 1..@num_players
      if @players[i].score > high_score
        winner = i
        high_score = @players[i].score
      end
    end
    return "The winner is Player #{i} with #{high_score} points."
  end
end

class Player
  def initialize(player_number)
    @score = 0
    @player_number = player_number
  end
  def add_score(value)
    @score += value
  end
  def score
    return @score
  end
end
