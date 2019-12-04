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
      num_range.each do |num|
        coordinates << "#{letter}#{num}"
      end
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

end
