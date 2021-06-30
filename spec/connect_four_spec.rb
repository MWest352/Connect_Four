# frozen_string_literal: true

# These are the tests for Connect Four from The Odin Project

require_relative '../lib/board.rb'
require_relative '../lib/main.rb'

describe Game do
  describe '#player_input' do

    subject(:game_input) { described_class.new }

    context 'when input is between accepted paramaters' do
      before do
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display error message' do
        error_message = "Entry Error: Please pick a number, 1 through 7!"
        expect(game_input).not_to receive(:puts).with(error_message)
        game_input.player_input
      end
    end

    context 'when user inputs an incorrect value once, then a valid input' do
      before do
        invalid_input = 'x'
        valid_input = '7'
        allow(game_input).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'completes loop and displays error message once' do
        prompt = "#{@current_player.name} Pick a Column"
        error_message = "Entry Error: Please pick a number, 1 through 7!"
        expect(game_input).to receive(:puts).with(prompt).once
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.player_input
      end
    end
  end
end

# Drop checker should take in player input and place that as 'column' in board.position
# The other coordinate should be the bottom most position (5) and check if empy.
# If empty  (if 'O'), replace with player symbol '0'
# If not empty, do -1, recheck for empty and loop -1 till empty or =1
# if row is full print 'row full' error.  

