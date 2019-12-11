class SmartComputer
  attr_reader :opponent_board, :opponent_ships

  def initialize(opponent_board, opponent_ships)
    @opponent_board = opponent_board
    @opponent_ships = opponent_ships
  end

  def set_guesses
    return_hash = {}
    horizontals = @opponent_board.generate_nested_coordinates(@opponent_board.grid_length)
    verticals = []
    vert_row = []
    range = 0..(@opponent_board.grid_length - 1)
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
    alive_ships = @opponent_ships.find_all { |ship| !ship.sunk?}
    require "pry"; binding.pry
    ship_sizes = alive_ships.map { |ship| ship.length }
    ship_target_size = ship_sizes.min
    valid_guesses = []
    options = set_guesses
    options[:horizontal].each do |row|
      valid_guesses << row.each_cons(ship_target_size).find_all do |group|
        no_sunks = group.none? { |coordinate| @opponent_board.cells[coordinate].render == "X"}
        no_misses = group.none? { |coordinate| @opponent_board.cells[coordinate].render == "M"}
        all_hits = group.all? { |coordinate| @opponent_board.cells[coordinate].render == "H"}
        no_sunks && no_misses && !all_hits
      end
    end
    options[:vertical].each do |row|
      valid_guesses << row.each_cons(ship_target_size).find_all do |group|
        no_sunks = group.none? { |coordinate| @opponent_board.cells[coordinate].render == "X"}
        no_misses = group.none? { |coordinate| @opponent_board.cells[coordinate].render == "M"}
        all_hits = group.all? { |coordinate| @opponent_board.cells[coordinate].render == "H"}
        no_sunks && no_misses && !all_hits
      end
    end
    valid_guesses = valid_guesses.flatten(1)
    require "pry"; binding.pry
  end
end
