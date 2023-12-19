# frozen_string_literal: true

require 'rspec'
require_relative '../lib/board'

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

    context 'When an not full column is picked' do
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
end
