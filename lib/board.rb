# frozen_string_literal: true

require 'tty-table'
require 'colorize'

# Create a board class that initializes a blank board imitating a connect four board
# It should have 6 rows and 7 columns with lines between columns and empty circles respectively placed

# Board Class
class Board
  attr_reader :board
  attr_accessor :rows

  def initialize
    generate_board
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
        r << 0
      end
    end
    @rows = rows
  end

  def print_board
    @table = TTY::Table.new headers, @rows
    puts @table.render(:unicode, alignment: [:center]).colorize(:color => :green)
  end

  def position(row, column)
    puts @table[row, column]
  end
end

# board = Board.new
# board.print_board
# board.position(5, 5)