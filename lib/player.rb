# frozen_string_literal: true

# Class to represent players
class Player
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def get_move(board)
    column_move = nil
    until board.valid_column?(column_move)
      puts "#{name}, place your move by column"
      column_move = gets.chomp.to_i
    end
    column_move
  end
end
