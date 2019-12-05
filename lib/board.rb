require_relative 'cell'

class Board
  attr_reader :cells

  def initialize(size = 4)
    @cells = {}
    coordinates = generate_coordinates(size)
    generate_cells(coordinates)

  end


  def valid_placement?(ship, coordinates)
    return false if ship.length != coordinates.length
    return false if !consecutive?(coordinates)

    true
  end

  def consecutive?(coordinates)
    numbers_consecutive = coordinates.each_cons(2).all? { |c1, c2| c1[1].to_i == c2[1].to_i - 1}
    numbers_same = coordinates.each_cons(2).all? { |c1, c2| c1[1].to_i == c2[1].to_i}
    letters_same = coordinates.each_cons(2).all? { |c1, c2| c1[0].ord == c2[0].ord}
    letters_consecutive = coordinates.each_cons(2).all? { |c1, c2| c1[0].ord == c2[0].ord - 1}
    return (numbers_consecutive && letters_same)||(numbers_same && letters_consecutive)
    #checking numbers consecutive
    # if coordinates.each_cons(2).all? {|c1,c2| c1[1].to_i == c2[1].to_i - 1}
    # #covert letters to .ord and all equal
    #   if coordinates.each_cons(2).all? {|c1,c2| c1[0].ord == c2[0].ord}
    #   true
    #   end
    # end
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
