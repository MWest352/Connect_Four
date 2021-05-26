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
    puts "Pick a Column"
    user_input = gets.chomp
    verified_number = verify_input(user_input.to_i) if user_input.match?(/^\d+$/)
    return verified_number if verified_number

    puts "Entry Error: Please pick a number, 1 through 7!"
    player_input
  end

  def verify_input(input)
    return input if input.between?(1, 7)
  end

  def switch_player
    if @current_player == @player_one
      @current_player = @player_two
    elsif @current_player == @player_two
      @current_player = @player_one
    end
  end

  def display_board
    @board.print_board
  end

  def input_shift
    player_input - 1
  end

  def checker
    @checker = @current_player.color
  end

  def board_position
    board.position(@bottom_position, input_shift)
  end

  def check_empty
    if board_position == "\u2687"
      @board = @board.gsub(/"#{board_position}"/, "#{@checker}")
      display_board
    else
      @bottom_position -= 1
      check_empty
    end
  end
end

game = Game.new
game.display_board
game.check_empty