# frozen_string_literal: true

# Create Player Class that allows for two players
# Each player should have a different color Blue or Red

# Player Class
class Player
  attr_accessor :name, :color, :choice

  def initialize(name, color)
    @name = name
    @color = color
    @choice = []
  end
  
end
