# frozen_string_literal: true

# This is the connect four game for The Odin Project's TDD section

# Outline:
# Create a board class that initializes a blank board imitating a connect four board
# It should have 6 rows and 7 columns with lines between columns and empty circles respectively placed

# Create Player Class that allows for two players
# Each player should have a different color Blue or Red

# Create a game class that fills each space on the columns 1 through 7
# Players choose which column they would like to drop their color in, and will be prompted 
#   to choose a number, 1 through 7
# When a player selects a row: their color should be placed in the bottom most open spot
# All columns should fill from bottom, and look to see if the space below it is already occupied
# Victory Check should search vertically, horizontally, and diagonally for four consecutive colors

# Requirements
require_relative 'player.rb'
require_relative 'board.rb'
require 'colorize'
require 'tty-table'
require 'byebug'

# Game Class
class Game
  attr_accessor :board
  def initialize
    #@board = Board.new
    @player_one = Player.new("Player 1", "\u2689".colorize(:color => :blue))
    @player_two = Player.new("Player 2", "\u2689".colorize(:color => :red))
    @current_player = @player_one
    @bottom_position = 5
    @turn = 0
  end

  def player_input
    column_number = gets.to_i
    if column_number.between?(1, 7)
      @column = column_number - 1
    else
      puts "Entry Error: Please pick a number, 1 through 7!"
      player_input
    end
  end

  def switch_player
    @bottom_position = 5
    if @current_player == @player_one
      @current_player = @player_two
    elsif @current_player == @player_two
      @current_player = @player_one
    end
  end

  def display_board
    @board.print_board
  end

  def board_position
    board.position(@bottom_position, @column)
  end

  def check_empty
    move_up until board_position == "\u2687"
    drop_checker
    make_player_array
  end

  def move_up
    @bottom_position -= 1
    @bottom_position >= 0 ? @bottom_position : try_again
  end

  def try_again
    puts "There are no more spaces in that row, Please try again."
    @bottom_position = 5
    player_input
  end

  def make_player_array
    @current_player.choice << [@bottom_position, @column]
  end

  def player_array
    @current_player.choice
  end

  def drop_checker
    board.drop_checker(@bottom_position, @column, @current_player.color)
    board.print_board
  end

  def run_game
    if @turn.zero?
      puts "#{@current_player.name} Pick a Column"
      player_input
      check_empty
      @turn += 1
      run_game
    else
      until win == true
        switch_player
        puts "#{@current_player.name} Pick a Column"
        player_input
        check_empty
      end
      game_over
    end
  end

  def vertical_win
    x = @bottom_position
    y = @column
    vert_match = [[x, y], [x + 1, y], [x + 2, y], [x + 3, y]]
    vert_match.all? { |e| player_array.include?(e) }
  end

  def diagonal_win
    x = @bottom_position
    y = @column
    diag_match1 = [[x, y], [x - 1, y + 1], [x - 2, y + 2], [x - 3, y + 3]]
    diag_match2 = [[x, y], [x + 1, y - 1], [x + 2, y - 2], [x + 3, y - 3]]
    diag_match1.all? { |e| player_array.include?(e) } ||
    diag_match2.all? { |e| player_array.include?(e) }
  end

  def horizontal_win
    x = @bottom_position
    y = @column
    horiz_match1 = [[x, y], [x, y - 1], [x, y - 2], [x, y - 3]]
    horiz_match2 = [[x, y], [x, y + 1], [x, y + 2], [x, y + 3]]
    horiz_match1.all? { |e| player_array.include?(e) } ||
    horiz_match2.all? { |e| player_array.include?(e) }
  end

  def win
    vertical_win == true ||
    diagonal_win == true ||
    horizontal_win == true
  end

  def game_over
    puts "Congradulations #{@current_player.name}, You've won! Play again? (y/n)"
    answer  = gets.chomp.downcase
    answer == "y" ? new_game : exit
  end

  def new_game
    game = Game.new
    game.run_game
  end
end

#  game = Game.new
#  game.run_game