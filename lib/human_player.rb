require_relative 'ship'
require_relative 'board'

class HumanPlayer
  attr_reader :board, :ships, :shots

  def initialize
    @board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @ships = [cruiser, submarine]
    @shots = []
  end

  def get_ready
    system("clear")
    puts ""
    initial_instructions
    system("clear")
    print_board
    @ships.each do |ship|
      ship_placement(ship)
    end
    press_enter_to_continue
  end

  def initial_instructions
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    press_enter_to_continue
  end

  def ship_placement(ship)
    puts ""
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)... "
    user_coordinates = []
    while !(@board.valid_placement?(ship, user_coordinates))
      user_coordinates = []
      (ship.length).times do |n|
        puts "Enter coordinate number #{n + 1}: "
        user_input = gets.chomp.upcase
        while !(@board.valid_coordinate?(user_input))
          system("clear")
          print_board
          puts "#{user_input} is not a valid coordinate, try again: "
          user_input = gets.chomp.upcase
        end
        user_coordinates << user_input
      end
      if !(@board.valid_placement?(ship, user_coordinates))
        system("clear")
        print "#{user_coordinates} are invalid coordinates. Please try again:"
        print_board
      end
    end
    system("clear")
    @board.place(ship, user_coordinates)
    print_board
    puts "#{ship.name} successfully placed!"
  end

  def print_board
    puts ""
    puts @board.render(true)
    puts ""
  end

  def press_enter_to_continue
    puts "Press enter to continue..."
    gets.chomp
  end

end
