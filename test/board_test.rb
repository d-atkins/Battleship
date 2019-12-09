require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board'
require_relative '../lib/cell'
require_relative '../lib/ship'

class BoardTest < Minitest::Test

  def test_it_exists #1
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_has_required_number_of_cells #2
    board = Board.new
    assert_equal 16, board.cells.count
    board2 = Board.new(8)
    assert_equal 64, board2.cells.count
  end

  def test_cells_are_a_hash #3
   board = Board.new
   assert_instance_of Hash, board.cells
  end

  def test_key_points_to_cell_object #4
    board = Board.new
    assert_instance_of Cell, board.cells.first[1]
  end

  def test_it_has_valid_coordinates #5
    board = Board.new
    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_it_ship_length_equals_coordinate_spaces #6
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false,board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2","A3"])
  end

  def test_coordinates_are_valid #7
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

  def test_diagonal_placement_is_invalid #8
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2","C3"])
    assert_equal false,board.valid_placement?(submarine, ["C3", "D4"])
  end

  def test_it_can_place_ship #9
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert cell_3.ship == cell_2.ship
  end

  def test_if_ship_overlapping #10
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_it_can_generate_cells #11
    board = Board.new(8)

    assert_equal 64, board.cells.count
    assert_instance_of Cell, board.cells["H8"]
    assert_nil board.cells["H9"]
  end

  def test_it_can_generate_nested_coordinates #12
    board = Board.new

    assert_equal [["A1"]], board.generate_nested_coordinates(1)
    assert_equal [["A1","A2"],["B1","B2"]], board.generate_nested_coordinates(2)
  end

  def test_it_can_check_if_coordinates_overlap #13
    board = Board.new

    assert_equal false, board.overlap?(["A1", "A2", "A3"])

    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal true, board.overlap?(["A1", "B1"])
  end

  def test_it_can_check_coordinates_are_consecutive #14
    board = Board.new

    assert_equal true, board.consecutive_coordinates?(["A1", "A2", "A3"])
    assert_equal true, board.consecutive_coordinates?(["B2", "C2"])
    assert_equal false, board.consecutive_coordinates?(["A2", "D5","D6"])
  end

  def test_it_can_check_numbers_are_consecutive #15
    board = Board.new

    assert_equal true, board.consecutive_numbers?([1,2,3])
    assert_equal true, board.consecutive_numbers?([28,29,30])
    assert_equal true, board.consecutive_numbers?([22,23,24,25])
    assert_equal false, board.consecutive_numbers?([5,10,7])
  end

  def test_it_can_check_numbers_are_same #16
    board = Board.new

    assert_equal true, board.same_numbers?([2,2])
    assert_equal false, board.same_numbers?([10,12])
  end

  def test_it_can_render_board #17
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.render
    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", board.render(true)
  end

end
