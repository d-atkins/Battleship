require "./lib/game"
require "./lib/game_computers"

puts "Press 'H' to play, press 'C' to watch CPU vs CPU"
choice = gets.chomp.capitalize
if choice == 'H'
  game = Game.new
  game.run
elsif choice == 'C'
  game2 = GameComputers.new
  game2.run
end
