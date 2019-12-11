class SmartComputer
  attr_reader :board, :ships, :opponent_ships

  def initialize(board, ships, opponent_ships)
    @board = board
    @ships = ships
    @opponent_ships = opponent_ships
  end

  def send_fire

  end

  def set_guesses
    return_hash = {}
    horizontals = @board.generate_nested_coordinates(@board.grid_length)
    verticals = []
    vert_row = []
    range = 0..(@board.grid_length - 1)
    range.each do |index|
      horizontals.each do |key_row|
        vert_row << key_row[index]
      end
      verticals << vert_row
      vert_row = []
    end
    return_hash[:horizontal] = horizontals
    return_hash[:vertical] = verticals
    return_hash
  end

  def generate_valid_guesses
    ship_sizes = @opponent_ships.map { |ship| ship.length }
    ship_target_size = ship_sizes.min
    valid_guesses = []
    options = set_guesses

    options[:horizontal].each do |row|
      valid_guesses << row.each_cons(ship_target_size).find_all do |group|

        no_sunks = group.none? { |coordinate| @board.cells[coordinate].render == "X"}
        no_misses = group.none? { |coordinate| @board.cells[coordinate].render == "M"}
        all_hits = group.all? { |coordinate| @board.cells[coordinate].render == "H"}
        no_sunks && no_misses && !all_hits

      end
    end
    require "pry"; binding.pry

  end

end
