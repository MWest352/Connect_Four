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
      let(:@bottom_position) { 1 }
      let(:@column) { 0 }
      it 'returns true' do
      player_array = [[5, 0], [5, 4], [4, 0], [5, 1], [3, 0], [2, 0]]
        allow(game.vertical_win).to receive(player_array).and_return true
      end
    context 'when coordinates do not match' do
      it 'returns false' do
        #expect(game.vertical_win).to be false
      end
    end
    end
  end
end

# Drop checker should take in player input and place that as 'column' in board.position
# The other coordinate should be the bottom most position (5) and check if empy.
# If empty  (if 'O'), replace with player symbol '0'
# If not empty, do -1, recheck for empty and loop -1 till empty or =1
# if row is full print 'row full' error.  

