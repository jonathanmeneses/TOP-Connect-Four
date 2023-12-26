# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength

class Board
  # Board Class to setup and initialize game.
  attr_accessor :grid

  def initialize
    @grid = Array.new(6, Array.new(7, nil))
  end

  def valid_column?(column)
    return false if column.nil?

    column_in_range = column.between?(0, 6)
    column_in_range && !full_column?(column)
  end

  def winning_move?(player)
    column_win?(player) || row_win?(player) || diagonal_win?(player)
  end

  def full_column?(column)
    grid.all? { |row| !row[column].nil? }
  end

  def full_board?
    grid.flatten.all? { |row| !row.nil? }
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

  def column_win?(player)
    grid[0].length.times do |col|
      flattened_column = grid.map { |row| row[col] }
      if flattened_column.each_cons(4).any? do |consecutive_cells|
           consecutive_cells.all? do |cell|
             cell == player.symbol
           end
         end
        return true
      end
    end
    false
  end

  def row_win?(player)
    grid.any? do |row|
      row.each_cons(4).any? do |consecutive_cells|
        consecutive_cells.all? do |x|
          x == player.symbol
        end
      end
    end
  end

  def diagonal_win?(player)
    diagonals = create_diagonals

    diagonals.any? { |array| array.all? { |x| x == player.symbol } }
  end

  def create_diagonals
    potential_winning_arrays = []
    (0..(grid[0].length - 4)).each do |col_start|
      (0..(grid.length - 1)).each do |row_start|
        # this pulls the set of arrays that could be winning combinations from a "diagonal" perspective
        if row_start < 3
          array_to_add = []
          4.times { |i| array_to_add << grid[row_start + i][col_start + i] }
          potential_winning_arrays << array_to_add

        elsif row_start >= 3
          antidiagonal_to_add = []
          # this pulls the set of arrays that could be winning combinations from an "anti-diagonal" perspective
          4.times { |i| antidiagonal_to_add << grid[row_start - i][col_start + i] }
          potential_winning_arrays << antidiagonal_to_add
        end
      end
    end
    potential_winning_arrays
  end

  def place_move(column, player)
    raise RangeError, 'Invalid Column Selection' unless valid_column?(column)

    # Start from the bottom of the grid and go upwards
    grid.reverse_each do |row|
      if row[column].nil?
        row[column] = player.symbol
        break # Exit the loop after replacing the value
      end
    end
    player
  end
end
