# frozen_string_literal: true

# These are the tests for Connect Four from The Odin Project

require_relative '../lib/board.rb'
require_relative '../lib/main.rb'
require 'byebug'

describe Game do

  subject(:game) { described_class.new }

  describe '#player_input' do
    context 'When input is between accepted paramaters' do
      before do
        valid_input = '3'
        allow(subject).to receive(:gets).and_return(valid_input)
      end

      it 'Stops loop and does not display error message' do
        error_message = "Entry Error: Please pick a number, 1 through 7!"
        expect(subject).not_to receive(:puts).with(error_message)
        subject.player_input
      end
    end

    context 'When user inputs an incorrect value once, then a valid input' do
      before do
        invalid_input = 'x'
        valid_input = '7'
        allow(subject).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'Completes loop and displays error message once' do
        error_message = "Entry Error: Please pick a number, 1 through 7!"
        expect(subject).to receive(:puts).with(error_message).once
        subject.player_input
      end
    end
  end

  describe '#move_up' do
    context 'When bottom position is 5' do
      it 'Returns 4' do
        @bottom_position = 5
        expect(game.move_up).to eq(4)
      end
    end
  end

  describe '#vertical_win' do
    context 'when coordinates match' do
      it 'returns true' do
        bottom_position = 2
        column = 0
        player_array = [[5, 0], [4, 0], [3, 0], [2, 0]] 
        expect(game.vertical_win(bottom_position, column, player_array)).to be true
      end
    end

    context 'when coordinates do not match' do
      it 'returns false' do
        bottom_position = 2
        column = 0
        player_array = []
        expect(game.vertical_win(bottom_position, column, player_array)).to be false
      end
    end
  end

  describe '#diagonal_win1' do
    context 'when coordinates match' do
      it 'returns true' do
        bottom_position = 2
        column = 3
        player_array = [[5, 0], [4, 1], [4, 2], [3, 2], [4, 3], [2, 3]] 
        expect(game.diagonal_win1(bottom_position, column, player_array)).to be true
      end
    end

    context 'when coordinates do not match' do
      it 'returns false' do
        bottom_position = 2
        column = 0
        player_array = []
        expect(game.diagonal_win1(bottom_position, column, player_array)).to be false
      end
    end
  end

  describe '#diagonal_win2' do
    context 'when coordinates match' do
      it 'returns true' do
        bottom_position = 2
        column = 0
        player_array = [[5, 1], [5, 3], [4, 2], [3, 1], [3, 0], [2, 0]] 
        expect(game.diagonal_win2(bottom_position, column, player_array)).to be true
      end
    end

    context 'when coordinates do not match' do
      it 'returns false' do
        bottom_position = 2
        column = 0
        player_array = []
        expect(game.diagonal_win2(bottom_position, column, player_array)).to be false
      end
    end
  end
end

