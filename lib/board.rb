# frozen_string_literal: true

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(6, Array.new(7, nil))
  end

  def valid_column?(column)
    column_in_range = column.between?(0,6)


    column_in_range && !full_column?(column)
  end

  def full_column?(column)
    self.grid.all? { |row| row[column] != nil}
  end
end
