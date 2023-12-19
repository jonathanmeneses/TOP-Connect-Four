# frozen_string_literal: true

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(6, Array.new(7, nil))
  end

  def valid_column?(column)
    column_in_range = column.between?(0, 6)
    column_in_range && !full_column?(column)
  end

  def full_column?(column)
    grid.all? { |row| !row[column].nil? }
  end

  def display_board
    puts '| 1 | 2 | 3 | 4 | 5 | 6 | 7 |'
    puts '-----------------------------'
    @grid.each do |row|
      print_view = '|'
      row.each do |cell|
        print_view += (cell.nil? ? '   |' : " #{cell} |")
      end
      puts print_view
    end
    puts '-----------------------------'
  end

  def column_win?(column, row, player)
    flattened_column = grid.map { |row_check| row_check[column] }
    flattened_column.each_cons(4).any? do |consecutive_cells|
      consecutive_cells.all? do |x|
        x == player
      end
    end
  end

  def row_win?(column, row, player)
    grid[row].each_cons(4).any? do |consecutive_cells|
      consecutive_cells.all? do |x|
        x == player
      end
    end
  end

  def diagonal_win?(column, row, player)



  end

  def create_diagonals()

    potential_winning_arrays = []
    (0..grid[0].length - 4).each do |col_start|
      (0..grid.length - 4).each do |row_start|
        array_to_add = []
        4.times {|i| array_to_add << grid[row_start+i][col_start+i]}
        potential_winning_arrays << array_to_add
      end
      ((grid.length-3)..grid.length).each do |row_start|
       array_to_add = []
       4.times {}
    end
     potential_winning_arrays
  end


end
