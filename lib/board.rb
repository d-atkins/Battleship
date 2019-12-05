require_relative 'cell'

class Board
  attr_reader :cells

  def initialize(size = 4)
    @cells = {}
    coordinates = generate_coordinates(size)
    generate_cells(coordinates)
  end

  def generate_coordinates(size)
    coordinates = []
    letter_range = "A".."Z"
    letter_range = "A"..letter_range.to_a[size - 1]
    num_range = 1..size
    letter_range.each do |letter|
      num_range.each { |num| coordinates << "#{letter}#{num}" }
    end
    coordinates
  end

  def generate_cells(coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate] = Cell.new(coordinate)
    end
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if ship.length != coordinates.length
    return false if !consecutive?(coordinates)
    true
  end

  def consecutive?(coordinates)
    letter_ords = coordinates.map do |coordinate|
      coordinate[0].ord
    end
    numbers = coordinates.map do |coordinate|
      coordinate[1..coordinate.length - 1].to_i
    end
    numbers_cons = check_consecutive(numbers)
    numbers_same = check_same(numbers)
    letters_cons = check_consecutive(letter_ords)
    letters_same = check_same(letter_ords)
    (numbers_cons && letters_same)||(numbers_same && letters_cons)
  end

  def check_consecutive(numbers)
    numbers.each_cons(2).all? { |num1, num2| num1 == num2 - 1}
  end

  def check_same(numbers)
    numbers.each_cons(2).all? { |num1, num2| num1 == num2}
  end

  def place
  end

end
