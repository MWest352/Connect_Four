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
        error_message = "Entry Error: Please pick a number, 1 through 7!"
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.player_input
      end
    end

    context 'when user inputs three incorrect answers (number outside of paramaters, symbol, letter) then valid input' do
      before do
        num_out_param = '10'
        symb = '#'
        letter = 'a'
        valid_input = '1'
        allow(game_input).to receive(:gets).and_return(num_out_param, symb, letter, valid_input)
      end

      it 'completes loop and displays error message three times' do
        error_message = "Entry Error: Please pick a number, 1 through 7!"
        expect(game_input).to receive(:puts).with(error_message).exactly(3).times
        game_input.player_input
      end
    end
  end

  describe '#verify_input' do
    subject(:verify_game) { described_class.new }

    context 'when given a valid input' do
      it 'returns valid input' do
        user_input = 4
        verified_input = verify_game.verify_input(user_input)
        expect(verified_input).to eq(4)
      end
    end

    context 'when given an invalid input' do
      it 'returns nil' do
        user_input = 27
        verified_input = verify_game.verify_input(user_input)
        expect(verified_input).to be_nil
      end
    end
  end

  describe '#drop_checker' do
    subject(:drop_checker) { described_class.new }

    context 'when placing checker' do
      it 'should change space on board' do

      end
    end
  end
end

# Drop checker should take in player input and place that as 'column' in board.position
# The other coordinate should be the bottom most position (5) and check if empy.
# If empty  (if 'O'), replace with player symbol '0'
# If not empty, do -1, recheck for empty and loop -1 till empty or =1
# if row is full print 'row full' error.  

