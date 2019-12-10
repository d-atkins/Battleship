require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board'
require_relative '../lib/ship'
require_relative '../lib/computer_player'

class ComputerPlayerTest < Minitest::Test

  def setup
    @computer = ComputerPlayer.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end
  def test_it_exists
    assert_instance_of ComputerPlayer, @computer
  end

  def test_it_has_attributes
    assert_instance_of Board, @computer.board
    assert_equal "Cruiser", @computer.ships[0].name
    assert_equal "Submarine", @computer.ships[1].name
    assert @computer.board.cells.has_key?("A1")
    assert_equal 16, @computer.board.cells.count
  end

  def test_ship_placement
    expected = @computer.board.cells.values.all?{ |cell| cell.empty? }
    assert_equal true, expected
    @computer.ship_placement(@cruiser)
    expected = @computer.board.cells.values.all?{ |cell| cell.empty? }
    assert_equal false, expected
  end

  def test_horizontal_array_maker_returns_an_array
    array = @computer.horizontal_array_maker(@cruiser, 3)
    assert_equal 3, array.count
    array = @computer.horizontal_array_maker(@submarine, 2)
    assert_equal 2, array.count
  end

  def test_vertical_array_maker_returns_an_array
    array = @computer.vertical_array_maker(@cruiser, 3)
    assert_equal 3, array.count
    array = @computer.vertical_array_maker(@submarine, 2)
    assert_equal 2, array.count
  end

  def test_it_can_send_fire
    computer = ComputerPlayer.new
    cpu_coordinate = computer.send_fire
    assert_equal true, computer.board.valid_coordinate?(cpu_coordinate)
  end

  def test_it_can_receive_fire
    computer = ComputerPlayer.new
    assert_equal false, computer.board.cells["B2"].fired_upon?
    computer.receive_fire("B2")
    assert_equal true, computer.board.cells["B2"].fired_upon?
    assert_equal "M", computer.board.cells["B2"].render
  end

end
