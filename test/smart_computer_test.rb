require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/computer_player'
require_relative '../lib/human_player'
require_relative '../lib/smart_computer'
require_relative '../lib/ship'
require_relative '../lib/board'

class SmartComputerTest < Minitest::Test

  def setup
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 3)
    ships = [cruiser, submarine]
    board = Board.new

    @smart_cpu = SmartComputer.new(board, ships)
  end

  def test_it
    @smart_cpu.opponent_board.cells["A1"].fire_upon
    @smart_cpu.opponent_board.cells["B1"].fire_upon
    @smart_cpu.opponent_board.cells["B3"].fire_upon
    @smart_cpu.opponent_board.cells["D4"].fire_upon
    @smart_cpu.opponent_board.cells["C1"].fire_upon
    @smart_cpu.opponent_board.cells["D2"].fire_upon
    @smart_cpu.opponent_board.cells["B2"].fire_upon

    @smart_cpu.generate_valid_guesses
  end

end
