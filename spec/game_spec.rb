# frozen_string_literal: true

require 'rspec'
require_relative '../lib/board'
require_relative '../lib/game'

describe Game do
  subject(:test_game) { described_class.new }
  describe '#set_player_symbol' do
    context 'When a valid player # & symbol is given' do
      it 'sets the player # to the given symbol' do
        expect { test_game.set_player_symbol('1', '&') }
          .to change { test_game.player_one }
          .from('X')
          .to('&')
      end
    end

    context 'When an invalid player # is given' do
      it 'returns an Argument Error' do
        expect { test_game.set_player_symbol('5', '&') }
          .to raise_error(ArgumentError)
      end
    end

    context 'When an invalid symbol is given' do
      it 'returns an ArgumentError' do
        expect { test_game.set_player_symbol('1', 'abc') }
          .to raise_error(ArgumentError)
      end
    end
  end
end
