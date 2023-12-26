# frozen_string_literal: true

require_relative '../lib/board'

# Defines the game and logic
class Game
  attr_accessor :player_one, :player_two, :board, :game_playing, :game_status_text

  def initialize(player_1, player_2)
    @player_one = player_1
    @player_two = player_2
    @board = Board.new
    @game_playing = true
    @game_status_text = nil
  end

  def place_move(player, column_move)
    board.place_move(column_move, player)
  end

  def play_game
    current_player = player_one
    while game_playing
      until move && valid_move?(move) # Assuming valid_move? is a method that checks move validity
        move = current_player.get_move
        board.place_move(move, current_player)
        # TODO: Add functionality to this section for logic
        if board.check_win?(player)

        end
        board.check
      end

    end
  end
end
