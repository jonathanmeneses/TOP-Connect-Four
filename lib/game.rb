# frozen_string_literal: true

require_relative '../lib/board'

# Defines the game and logic
class Game
  attr_accessor :player_one, :player_two, :board, :game_playing, :game_status_text, :current_player

  def initialize(player_1, player_2)
    @player_one = player_1
    @player_two = player_2
    @board = Board.new
    @current_player = @player_one
    @game_playing = true
    @game_status_text = nil
  end

  def place_move(player, column_move)
    board.place_move(column_move, player)
  end

  def game_turns
    if board.winning_move?(current_player)
      game_status_text = "#{current_player.name} wins the game!"
      game_playing = false
    elsif board.full_board?
      game_status_text = "It's a draw!"
      game_playing = false
    end
    current_player = (current_player == player_one ? player_one : player_two)
  end

  def end_sequence
    board.display_board
    puts "Game Over! \n"
    puts game_status_text
  end

  def start_sequence
    puts 'Welcome to Connect 4!'
    puts "The goal of the game is to connect 4 pieces in a row. Let's start!"
  end

  def play_game # rubocop:disable Metrics/AbcSize
    while game_playing
      move = nil
      board.display_board
      start_sequence
      puts "#{current_player.name}, Place your move!"
      until move && board.valid_column?(move) # Assuming valid_move? is a method that checks move validity
        move = current_player.get_move(board)
        # binding.pry
      end
      board.place_move(move, current_player)
      if board.winning_move?(current_player)
        self.game_status_text = "#{current_player.name} wins the game!"
        self.game_playing = false
      elsif board.full_board?
        self.game_status_text = "It's a draw!"
        self.game_playing = false
      end
      self.current_player = if current_player == player_one
                              player_two
                            else
                              player_one
                            end
    end
    end_sequence
  end
end
