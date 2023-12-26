# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/game'

board = Board.new
board.grid = [['X', nil, nil, nil, nil, nil, nil],
              ['X', nil, nil, nil, nil, nil, nil],
              ['X', nil, nil, 'X', nil, nil, 'X'],
              ['X', nil, 'X', nil, 'X', 'X', 'X'],
              ['X', 'X', nil, 'X', nil, 'X', 'X'],
              ['X', nil, 'X', nil, nil, 'X', 'X']]
p board.column_win?(5, 'X')

p board.create_diagonals.length

player1 = Player.new('Jonathan', 'X')
player2 = Player.new('Sarah', 'O')
move = player1.get_move(board)

game = Game.new(player1, player2)

game.place_move(player1, move)

p board.grid
