require './game.rb'

game = Codebreaker::Game.new($stdout, $stdin)
game.start
