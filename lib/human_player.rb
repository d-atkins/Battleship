require_relative 'ship'
require_relative 'board'

class HumanPlayer
  attr_reader :board, :ships, :shots, :size, :name

  def initialize(name, size = 4)
    @name = name
    set_default
  end

  def set_classic
    @size = 10
    carrier = Ship.new("Carrier", 5)
    battleship = Ship.new("Battleship", 4)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 3)
    destroyer = Ship.new("Destroyer", 2)
    @ships = [carrier, battleship, cruiser, submarine, destroyer]
  end

  def set_default
    @size = 4
    @board = Board.new(size)
    cruiser = Ship.new("Cruiser", 3)
    destroyer = Ship.new("Destroyer", 2)
    @ships = [cruiser, destroyer]
  end

  def reset
    @board = Board.new(@size)
    refresh_ships
    @shots = []
  end

  def refresh_ships
    @ships = @ships.map do |ship|
      name = ship.name
      length = ship.length
      ship = Ship.new(name, length)
      ship
    end
  end

  def get_ready
    reset
    system("clear")
    initial_instructions
    system("clear")
    print_board
    @ships.each do |ship|
      ship_placement(ship)
    end
    press_enter_to_continue
  end

  def initial_instructions
    print_board
    puts "You now need to lay out your two ships."
    puts ""
    @ships.each do |ship|
      puts "The #{ship.name} is #{ship.length} units long."
    end
    puts ""
    press_enter_to_continue
  end

  def ship_placement(ship)
    puts ""
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)... "
    user_coordinates = []
    while !(@board.valid_placement?(ship, user_coordinates))
      user_coordinates = []
      (ship.length).times do |n|
        print "Enter coordinate ##{n + 1}: "
        user_input = gets.chomp.upcase
        while !(@board.valid_coordinate?(user_input))
          puts "ERROR: #{user_input} is not a valid coordinate, try again"
          print "Enter coordinate ##{n + 1}: "
          user_input = gets.chomp.upcase
        end
        user_coordinates << user_input
      end
      if !(@board.valid_placement?(ship, user_coordinates))
        system("clear")
        print_board
        puts "#{user_coordinates} are invalid coordinates. Please try again."
        puts ""
      end
    end
    system("clear")
    @board.place(ship, user_coordinates)
    print_board
    puts "#{ship.name} successfully placed!"
  end

  def print_board
    puts "==============PLAYER BOARD=============="
    puts @board.render(true)
    puts ""
  end

  def press_enter_to_continue
    print "(press "+ $white_bold + "ENTER" + $color_restore + " to continue...)"
    gets.chomp
  end

  def send_fire
    print "Enter the coordinate for your shot: "
    user_coor = gets.chomp.upcase
    until (@board.valid_coordinate?(user_coor) && !@shots.include?(user_coor))
      if !@board.valid_coordinate?(user_coor)
        print "Please enter a valid coordinate: "
      else
        print "You have already fired upon #{user_coor}. Try again: "
      end
      user_coor = gets.chomp.upcase
    end
    @shots << user_coor

    user_coor
  end

  def receive_fire(coordinate)
    @board.cells[coordinate].fire_upon
    print "#{name} shot at #{target}... "
  end

end
