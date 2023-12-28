# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/game'

board = Board.new

player1 = Player.new('Jonathan', 'X')
player2 = Player.new('Sarah', 'O')

game = Game.new(player1, player2)

game.play_game
