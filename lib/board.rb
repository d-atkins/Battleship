require_relative 'cell'

class Board
  attr_reader :cells

  def initialize

    @cells = {
      "A1" => Cell.new("A1"),
       "A2" => Cell.new("A2"),
       "A3" => Cell.new("A3"),
       "A4" => Cell.new("A4"),
       "B1" => Cell.new("B1"),
       "B2" => Cell.new("B2"),
       "B3" => Cell.new("B3"),
       "B4" => Cell.new("B4"),
       "C1" => Cell.new("C1"),
       "C2" => Cell.new("C2"),
       "C3" => Cell.new("C3"),
       "C4" => Cell.new("C4"),
       "D1" => Cell.new("D1"),
       "D2" => Cell.new("D2"),
       "D3" => Cell.new("D3"),
       "D4" => Cell.new("D4")
      }
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





end
