require_relative 'ship'
require_relative 'board'

class ComputerPlayer
  attr_reader :board, :ships

  def initialize
    @board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @ships = [cruiser, submarine]
    @coordinate_guesses = @board.cells.keys
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
  end

  def initial_instructions
    puts "I have laid out my ships on the grid."
  end

  def ship_placement(ship)
    #random coordinate generator
    length = ship.length
    initial_guess = @coordinate_guesses.sample
    # random pick horizontal(whole row) or vertical(whole column)
    h_or_v = [1,2].sample
      if h_or_v == 1
        horizontal_array_maker(initial_guess, length)
      else
        vertical_array_maker(initial_guess, length)
      end
    # generate array based on initial guess


  end

  def horizontal_array_maker(initial_guess, length) # "A1"

    computer_array = [initial_guess]
    cell_int = (initial_guess[1..initial_guess.length - 1]).to_i
    (length - 1).times do
      cell_int += 1
      computer_array << initial_guess[0] + cell_int.to_s
    end
    require "pry"; binding.pry
  end

  def vertical_array_maker(initial_guess, length)
    computer_array = [initial_guess]
    cell_int = initial_guess[1..initial_guess.length - 1]
    cell_letter = (initial_guess[0]).ord
    (length - 1).times do
      cell_letter += 1
      computer_array << cell_letter.chr + cell_int
    end
    require "pry"; binding.pry

  end

  def print_board
    puts ""
    puts @board.render
    puts ""
  end


end
