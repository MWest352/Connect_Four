# frozen_string_literal: false

require 'tty-table'
require 'colorize'

# Create a board class that initializes a blank board imitating a connect four board
# It should have 6 rows and 7 columns with lines between columns and empty circles respectively placed

# Board Class
class Board
  attr_accessor :rows, :board

  def initialize
    generate_board
    print_board
  end

  def headers
    ["Row 1", "Row 2", "Row 3", "Row 4", "Row 5", "Row 6", "Row 7"]
  end

  def generate_board
    rows = []
    6.times do
      rows << []
    end

    rows.each do |r|
      7.times do
        r << "\u2687"
      end
    end
    @rows = rows
  end

  def print_board
    @table = TTY::Table.new headers, @rows
    puts @table.render(:unicode, alignment: [:center])
  end

  def position(row, column)
    @table[row, column]
  end

  def drop_checker(row, column, x)
    @rows[row][column] = "#{x}"
  end
  
end
