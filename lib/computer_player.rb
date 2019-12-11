require_relative 'ship'
require_relative 'board'

class ComputerPlayer
  attr_reader :board, :ships

  def reset(size = 4)
    @board = Board.new(size)
    carrier = Ship.new("Carrier", 5)
    battleship = Ship.new("Battleship", 4)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 3)
    destroyer = Ship.new("Destroyer", 2)
    @ships = [carrier, battleship, cruiser, submarine, destroyer]
    @coordinate_guesses = @board.cells.keys
  end

  def get_ready(size = 4)
    reset(size)
    initial_instructions
    @ships.each do |ship|
      ship_placement(ship)
    end
  end

  def initial_instructions
    puts "I am laying out my ships..."
    # sleep(3)
  end

  def ship_placement(ship)
    length = ship.length
    coin_toss = [1,2].sample
    if coin_toss == 1
      computer_array = horizontal_array_maker(ship, length)
    else
      computer_array = vertical_array_maker(ship, length)
    end
    @board.place(ship, computer_array)
  end

  def horizontal_array_maker(ship, length)
    computer_array = []
    while !(computer_array.all?{ |coor| @board.valid_coordinate?(coor)} &&
      @board.valid_placement?(ship, computer_array))
      computer_array = []
      initial_guess = @coordinate_guesses.sample
      computer_array = [initial_guess]
      cell_int = (initial_guess[1..initial_guess.length - 1]).to_i
      (length - 1).times do
        cell_int += 1
        computer_array << initial_guess[0] + cell_int.to_s
      end
    end
    computer_array
  end

  def vertical_array_maker(ship, length)
    computer_array = []
    while !(computer_array.all?{ |coor| @board.valid_coordinate?(coor)} &&
      @board.valid_placement?(ship, computer_array))
      computer_array = []
      initial_guess = @coordinate_guesses.sample
      computer_array = [initial_guess]
      cell_int = initial_guess[1..initial_guess.length - 1]
      cell_letter = (initial_guess[0]).ord
      (length - 1).times do
        cell_letter += 1
        computer_array << cell_letter.chr + cell_int
      end
    end
    computer_array
  end

  def print_board(game_over = false)
    puts "=============COMPUTER BOARD============="
    puts @board.render if !game_over
    puts @board.render(true) if game_over
    puts ""
  end

  def receive_fire(coordinate)
    @board.cells[coordinate].fire_upon
    print "HUMAN shot at #{coordinate}... "
    sleep(0.1)

  end

  def send_fire
    @coordinate_guesses.delete(@coordinate_guesses.sample)
  end

end
