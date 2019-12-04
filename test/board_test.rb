require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board'
require_relative '../lib/cell'

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
end
