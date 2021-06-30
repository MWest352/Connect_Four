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
    @board = Board.new
    @player_one = Player.new("Player 1", "\u2689".colorize(:color => :blue))
    @player_two = Player.new("Player 2", "\u2689".colorize(:color => :red))
    @current_player = @player_one
    @bottom_position = 5
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
    until board_position == "\u2687"
      @bottom_position -= 1
    end
    drop_checker
    @current_player.choice << [@bottom_position, @column]
    puts "#{@current_player.choice}" 
  end

  def drop_checker
    board.drop_checker(@bottom_position, @column, @current_player.color)
    board.print_board
  end

  def run_game
    until win == true
      puts "#{@current_player.name} Pick a Column"
      player_input
      check_empty
      switch_player
    end
  end

  # def pos_diag_win
  #   x = @bottom_position
  #   puts "#{x}"
  #   y = @column
  #   if @current_player.choice =
  #        [[x, y], [x - 1, y + 1], [x - 2, y + 2], [x - 3, y + 3]]
  #     pos_diag_win = true
  #   else
  #     pos_diag_win = false
  #   end
  # end
  
  def win
    # if pos_diag_win == true
    #   win = true
    # else 
    #   win = false
    # end
  end
end

 game = Game.new
 game.run_game

