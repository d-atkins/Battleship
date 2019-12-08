require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board'
require_relative '../lib/cell'
require_relative '../lib/ship'
require_relative '../lib/computer_player'

class ComputerPlayerTest < Minitest::Test

  def test_things
    computer = ComputerPlayer.new
    computer.get_ready
  end
end
