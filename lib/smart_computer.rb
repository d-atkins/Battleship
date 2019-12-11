class SmartComputer
  attr_reader :opponent_board, :opponent_ships

  def initialize(opponent_board, opponent_ships)
    @opponent_board = opponent_board
    @opponent_ships = opponent_ships
  end

  def send_fire
    suggest_coordinate
  end

  def suggest_coordinate
    coordinates = find_groups_with_most_hits.flatten
    guesses = remove_fired_upon_coordinates(coordinates)
    guesses.uniq.sample
  end

  def remove_fired_upon_coordinates(coordinates)
    guesses = coordinates.find_all do |coordinate|
      !@opponent_board.cells[coordinate].fired_upon?
    end
    guesses
  end

  def find_groups_with_most_hits
    guesses = generate_valid_guesses
    best_guesses = []
    most_hits = 0
    guesses.each do |group|
      this_group_hits = count_hits(group)
      if this_group_hits > most_hits
        best_guesses = []
        best_guesses << group
        most_hits = this_group_hits
      elsif this_group_hits == most_hits
        best_guesses << group
      end
    end
    best_guesses
  end

  def count_hits(group)
    group_render = group.map { |coordinate| @opponent_board.cells[coordinate].render }
    group_render.count("H")
  end

  def all_guesses
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
    ship_sizes = alive_ships.map { |ship| ship.length }
    ship_target_size = ship_sizes.min
    valid_guesses = []
    options = all_guesses
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
  end
end
