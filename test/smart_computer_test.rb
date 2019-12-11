require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/computer_player'
require_relative '../lib/human_player'
require_relative '../lib/smart_computer'
require_relative '../lib/ship'
require_relative '../lib/board'

class SmartComputerTest < Minitest::Test

  def setup
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    ships1 = [cruiser1, submarine1]
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    ships2 = [cruiser2, submarine2]
    board = Board.new
    @smart_cpu = SmartComputer.new(board, ships1, ships2)
  end

  def test_it_exists
    @smart_cpu.board.cells["A1"].fire_upon
    @smart_cpu.board.cells["B1"].fire_upon
    @smart_cpu.board.cells["B3"].fire_upon
    @smart_cpu.board.cells["D4"].fire_upon
    @smart_cpu.generate_valid_guesses
  end

end
