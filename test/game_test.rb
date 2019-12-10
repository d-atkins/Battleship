require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board'
require_relative '../lib/ship'
require_relative '../lib/computer_player'
require_relative '../lib/human_player'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def test_it_exists #1
    game = Game.new
    assert_instance_of Game, game
  end

  def test_it_has_attributes
    game = Game.new
    require "pry"; binding.pry
    assert_instance_of ComputerPlayer, game.computer
    assert_instance_of HumanPlayer, game.human
  end

  def test_it_got_ready
    skip
    # are there ships assigned to cells?
  end

  def test_take_turn
    skip
  end

end
