require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell'
require_relative '../lib/ship'

class CellTest < Minitest::Test

  def test_it_exists
    # skip
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
  end

  def test_what_ship_is_there
    # skip
    cell = Cell.new("B4")
    assert_nil cell.ship
  end

  def test_coordinate_name
    # skip
    cell = Cell.new("B4")
    assert_equal "B4", cell.coordinate
  end

  def test_is_cell_empty
    cell = Cell.new("B4")
    assert_equal true, cell.empty?
  end

  def test_it_can_place_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
  end

  def test_cell_no_longer_empty
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    assert_equal false, cell.empty?
  end

  def test_can_it_be_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fired_upon?
    assert_equal false, cell.fired_upon?
    cell.fire_upon
    assert_equal 2, cell.ship.health
    assert_equal true, cell.fired_upon?
  end

end
