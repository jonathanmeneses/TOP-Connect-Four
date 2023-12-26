# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rspec'
require_relative '../lib/board'
require_relative '../lib/game'

describe Board do
  describe '#initialize' do
    context '#When a board is created' do
      subject(:test_board) { described_class.new }

      it 'there is an empty 6x7 board' do
        expect(test_board.grid).to be_a(Array)
        expect(test_board.grid.length).to eq(6)
        expect(test_board.grid.all? { |row| row.length == 7 }).to be true
      end

      it 'the board has all empty spaces' do
        expect(test_board.grid.flatten.all?(&:nil?)).to be true
      end
    end
  end

  describe '#full_column?' do
    subject(:partially_filled_board) { described_class.new }

    before do
      partially_filled_board.grid = [['X', nil, nil, nil, nil, nil, nil], ['X', nil, nil, nil, nil, nil, nil],
                                     ['X', nil, nil, nil, nil, nil, 'X'], ['X', nil, nil, nil, nil, nil, 'X'],
                                     ['X', nil, nil, nil, nil, nil, 'X'], ['X', nil, nil, nil, nil, nil, 'X']]
    end

    context 'When a full column is picked' do
      it 'returns true' do
        expect(partially_filled_board.full_column?(0)).to be true
      end
    end

    context 'When an ot full column is picked' do
      context 'that is empty' do
        it 'returns false' do
          expect(partially_filled_board.full_column?(1)).to be false
        end
      end
      context 'that is partially full' do
        it 'returns false' do
          expect(partially_filled_board.full_column?(6)).to be false
        end
      end
    end
  end

  describe '#valid_column?' do
    subject(:partially_filled_board) { described_class.new }

    before do
      partially_filled_board.grid = [['X', nil, nil, nil, nil, nil, nil], ['X', nil, nil, nil, nil, nil, nil],
                                     ['X', nil, nil, nil, nil, nil, 'X'], ['X', nil, nil, nil, nil, nil, 'X'],
                                     ['X', nil, nil, nil, nil, nil, 'X'], ['X', nil, nil, nil, nil, nil, 'X']]
    end

    context 'When a valid column is picked' do
      context 'that is empty' do
        it 'returns true' do
          allow(partially_filled_board).to receive(:full_column?).and_return(false)
          expect(partially_filled_board.valid_column?(3)).to be true
        end
      end

      context 'that is partially full' do
        it 'returns true' do
          allow(partially_filled_board).to receive(:full_column?).and_return(false)
          expect(partially_filled_board.valid_column?(6)).to be true
        end
      end
    end

    context 'When an invalid column is placed' do
      context 'When the column is out of range' do
        it 'returns false' do
          allow(partially_filled_board).to receive(:full_column?).and_return(false)
          expect(partially_filled_board.valid_column?(10)).to be false
        end
      end

      context 'When the selected column is full' do
        it 'returns false' do
          allow(partially_filled_board).to receive(:full_column?).and_return(true)
          expect(partially_filled_board.valid_column?(0)).to be false
        end
      end
    end
  end

  describe '#column_win?' do
    subject(:test_board) { described_class.new }

    before do
      test_board.grid = [['X', nil, nil, nil, nil, nil, nil],
                         ['X', nil, nil, nil, nil, nil, nil],
                         ['X', nil, nil, nil, nil, nil, 'X'],
                         ['X', nil, nil, nil, nil, nil, 'X'],
                         ['X', nil, nil, nil, nil, nil, 'X'],
                         ['X', nil, nil, nil, nil, nil, 'X']]
    end

    context 'When there is a sequence of four in the given column' do
      it 'returns true' do
        expect(test_board.column_win?(0, 10, 'X')).to be(true)
      end
    end

    context 'When there is not a sequence of four in the given column' do
      it 'returns false' do
        expect(test_board.column_win?(2, 10, 'X')).to be(false)
      end
    end
  end

  describe '#row_win?' do
    subject(:test_board) { described_class.new }

    before do
      test_board.grid = [['X', nil, nil, nil, nil, nil, nil],
                         ['X', 'X', 'X', 'X', nil, nil, nil],
                         ['X', nil, nil, nil, nil, nil, 'X'],
                         [nil, nil, nil, nil, nil, nil, 'X'],
                         [nil, nil, nil, nil, nil, nil, 'X'],
                         [nil, nil, nil, nil, nil, nil, 'X']]
    end

    context 'When there is a sequence of four in the given row' do
      it 'returns true' do
        expect(test_board.row_win?(10, 1, 'X')).to be(true)
      end
    end

    context 'When there is not a sequence of four in the given row' do
      it 'returns false' do
        expect(test_board.row_win?(10, 2, 'X')).to be(false)
      end
    end
  end

  describe '#create_diagonals?' do
    subject(:test_board) { described_class.new }

    before do
      test_board.grid =
        [[nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, 'X'],
         [nil, nil, nil, nil, 'O', 'X', 'O'],
         [nil, nil, nil, nil, 'X', 'O', 'O'],
         [nil, 'O', 'O', 'X', 'O', 'O', 'O']]
    end
    context 'When create_diagonals is called' do
      it 'returns 24 arrays' do
        expect(test_board.create_diagonals.length).to eq(24)
      end
    end
  end

  describe '#diagonal_win?' do
    subject(:test_board) { described_class.new }

    context 'When there is a winning combination' do
      return_arrays = [['X', nil, nil, nil], ['X', nil, 'X', nil], ['X', nil, nil, nil], ['X', nil, nil, nil],
                       ['X', nil, nil, nil], %w[X X X X], [nil, nil, 'X', nil], [nil, nil, nil, nil],
                       [nil, 'X', nil, nil], [nil, nil, nil, nil], ['X', 'X', 'X', nil], [nil, nil, nil, nil],
                       [nil, nil, nil, 'X'], [nil, 'X', nil, 'X'], [nil, nil, nil, 'X'], ['X', 'X', nil, nil],
                       [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, 'X'], [nil, nil, 'X', 'X'],
                       ['X', nil, 'X', 'X'], [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, 'X', 'X']]

      it 'returns true' do
        allow(test_board).to receive(:create_diagonals).and_return(return_arrays)
        expect(test_board.diagonal_win?('X')).to be(true)
      end
    end

    context 'When there is not a winning combination' do
      return_arrays =   [['X', nil, nil, nil], ['X', nil, 'X', nil], ['X', nil, nil, nil], ['X', nil, nil, nil],
                         ['X', nil, nil, nil], ['X', nil, 'X', 'X'], [nil, nil, 'X', nil], [nil, nil, nil, nil],
                         [nil, 'X', nil, nil], [nil, nil, nil, nil], ['X', 'X', 'X', nil], [nil, nil, nil, nil],
                         [nil, nil, nil, 'X'], [nil, 'X', nil, 'X'], [nil, nil, nil, 'X'], ['X', 'X', nil, nil],
                         [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, 'X'], [nil, nil, 'X', 'X'],
                         ['X', nil, 'X', 'X'], [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, 'X', 'X']]
      it 'returns false' do
        allow(test_board).to receive(:create_diagonals).and_return(return_arrays)
        expect(test_board.diagonal_win?('X')).to be(false)
      end
    end

    context 'When there is a winning combination, but not with the passed symbol' do
      return_arrays = [['X', nil, nil, nil], ['X', nil, 'X', nil], ['X', nil, nil, nil], ['X', nil, nil, nil],
                       ['X', nil, nil, nil], %w[X X X X], [nil, nil, 'X', nil], [nil, nil, nil, nil],
                       [nil, 'X', nil, nil], [nil, nil, nil, nil], ['X', 'X', 'X', nil], [nil, nil, nil, nil],
                       [nil, nil, nil, 'X'], [nil, 'O', nil, 'O'], [nil, nil, nil, 'X'], ['X', 'X', nil, nil],
                       [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, 'X'], [nil, nil, 'X', 'X'],
                       ['X', nil, 'X', 'X'], [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, 'X', 'X']]
      it 'returns false' do
        allow(test_board).to receive(:create_diagonals).and_return(return_arrays)
        expect(test_board.diagonal_win?('O')).to be(false)
      end
    end
  end

  describe '#place_move' do
    subject(:test_board) { described_class.new }

    before do
      test_board.grid = [['X', nil, nil, nil, nil, nil, 'X'],
                         ['X', 'X', 'X', nil, nil, nil, 'X'],
                         ['X', nil, nil, nil, nil, nil, 'X'],
                         [nil, nil, nil, nil, nil, nil, 'X'],
                         [nil, nil, nil, nil, nil, nil, 'X'],
                         [nil, nil, nil, 'X', nil, nil, 'X']]
    end

    context 'When a move is placed in an empty column' do
      it 'move is placed to the bottom of the column' do
        expect { test_board.place_move(5, '0') }
          .to change { test_board.grid[5][5] }
          .from(nil)
          .to('0')
      end
    end

    context 'when a move is placed in a partially full column' do
      it 'move is placed at the last not filled row' do
        expect { test_board.place_move(3, '0') }
          .to change { test_board.grid[4][3] }
          .from(nil)
          .to('0')
      end
    end

    context 'When move is placed in a full column' do
      it 'returns error' do
        expect { test_board.place_move(6, '0') }
          .to raise_error(RangeError)
      end
    end

    context 'When move is placed in an invalid column' do
      it 'returns error' do
        expect { test_board.place_move(9, '0') }
          .to raise_error(RangeError)
      end
    end
  end
end
