#frozen_string_literal: true

require_relative '../lib/board.rb'

board = Board.new
board.grid =                        [['X', nil, nil, nil, nil, nil, nil],
                                     ['X', nil, nil, nil, nil, nil, nil],
                                     ['X', nil, nil, 'X', nil, nil, 'X'],
                                     ['X', nil, 'X', nil, "X", "X", 'X'],
                                     ['X', 'X', nil, "X", nil, "X", 'X'],
                                     ['X', nil, "X", nil, nil, "X", 'X']]
p board.column_win?(5,1,"X")


p board.create_diagonals.length
