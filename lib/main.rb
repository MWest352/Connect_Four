# frozen_string_literal: true

# This is the connect four game for The Odin Project's TDD section

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
    # @board = Board.new
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
    puts "#{player_array}"
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

  def vertical_win(x, y, player_array)
    vert_match = [[x, y], [x + 1, y], [x + 2, y], [x + 3, y]]
    vert_match.all? { |e| player_array.include?(e) }
  end

  def diagonal_win1(x, y, player_array)
    diag_match1 = [[x, y], [x + 1, y - 1], [x + 2, y - 2], [x + 3, y - 3]]
    diag_match1.all? { |e| player_array.include?(e) }
  end

  def diagonal_win2(x, y, player_array)
    diag_match2 = [[x, y], [x + 1, y + 1], [x + 2, y + 2], [x + 3, y + 3]]
    diag_match2.all? { |e| player_array.include?(e) }
  end

  def horizontal_win(x, y, player_array)
    horiz_match1 = [[x, y], [x, y - 1], [x, y - 2], [x, y - 3]]
    horiz_match2 = [[x, y], [x, y + 1], [x, y + 2], [x, y + 3]]
    horiz_match1.all? { |e| player_array.include?(e) } ||
      horiz_match2.all? { |e| player_array.include?(e) }
  end

  def win
    vertical_win(@bottom_position, @column, player_array) == true ||
      diagonal_win1(@bottom_position, @column, player_array) == true ||
      diagonal_win2(@bottom_position, @column, player_array) == true ||
      horizontal_win(@bottom_position, @column, player_array) == true
  end

  def game_over
    puts "Congradulations #{@current_player.name}, You've won! Play again? (y/n)"
    answer = gets.chomp.downcase
    answer == "y" ? new_game : exit
  end

  def new_game
    game = Game.new
    game.run_game
  end
end

#  game = Game.new
#  game.run_game