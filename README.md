# Connect_Four

# This is the connect four game for The Odin Project's TDD section

# Outline:
# Create a board class that initializes a blank board imitating a connect four board
# It should have 6 rows and 7 columns with lines between columns and empty circles respectively placed

# Create Player Class that allows for two players
# Each player should have a different color Blue or Red

# Create a game class that fills each space on the columns 1 through 7
# Players choose which column they would like to drop their color in, and will be prompted to choose a number, 1 through 7
# When a player selects a row: their color should be placed in the bottom most open spot
# All columns should fill from bottom, and look to see if the space below it is already occupied
# Victory Check should search vertically, horizontally, and diagonally for four consecutive colors
