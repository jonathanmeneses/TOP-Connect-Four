# frozen_string_literal: true

require_relative '../lib/board'

# Defines the game and logic
class Game
  attr_accessor :player_one, :player_two

  def initialize(player_1, player_2)
    @player_one = player_1
    @player_two = player_2
    @board = Board.new
  end
end

# I think i actually want to create a player class..
#
