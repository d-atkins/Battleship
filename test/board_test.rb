require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board'
require_relative '../lib/cell'
require_relative '../lib/ship'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_has_required_number_of_cells
    board = Board.new
    assert_equal 16, board.cells.count
  end

  def test_cells_are_a_hash
   board = Board.new
   assert_instance_of Hash, board.cells
  end

  def test_key_points_to_cell_object
    board = Board.new
    assert_instance_of Cell, board.cells.first[1]
  end

  def test_it_has_valid_coordinates
    board = Board.new
    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_it_ship_length_equals_coordinate_spaces
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false,board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2","A3"])
  end

  def test_coordinates_are_consecutive
    # skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2","A4"])
    assert_equal false,board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2","A1"])#true???
    assert_equal false,board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2","A3"])
    assert_equal true,board.valid_placement?(submarine, ["B1", "C1"])
  end

  def test_diagonal_placement_invalid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2","C3"])
    assert_equal false,board.valid_placement?(submarine, ["C3", "D4"])
  end
end
