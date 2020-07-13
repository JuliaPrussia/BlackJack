#start
require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'
require_relative 'interface'
require_relative 'hand'
require_relative 'bank'
require_relative 'game'

game = Game.new
game.start
