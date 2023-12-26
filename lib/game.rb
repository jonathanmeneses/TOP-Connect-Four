# frozen_string_literal: true

require_relative '../lib/board'

class Game
  attr_accessor :player_one, :player_two

  def initialize(player_1_symbol = 'X', player_2_symbol = 'O')
    @player_one = player_1_symbol
    @player_two = player_2_symbol
    @board = Board.new
  end

  def set_player_symbol(player, symbol)
    # sets the player symbol for the chosen player
    raise ArgumentError, 'Symbol cannot be empty' if symbol.to_s.empty?

    raise ArgumentError, 'Symbol must be 1 character' if symbol.to_s.length != 1

    case player.to_i
    when 1
      self.player_one = symbol
    when 2
      self.player_two = symbol
    else
      raise ArgumentError, 'Invalid Player Number'
    end
  end

  def get_argument(player)
    raise ArgumentError, 'Must be 1 or 2' if player.to_i != 1 || player.to_i != 2

    column_move = nil
    until board.valid_column?(column_move)
      column_move = gets.chomp.to_i

      puts "Player #{player}, place your move by column"

      board.place_move(column_move, player)

    end
  end
end

# I think i actually want to create a player class..
#
