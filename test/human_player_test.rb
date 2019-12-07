require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/human_player'

class HumanPlayerTest < Minitest::Test

  def test_things
    human = HumanPlayer.new
    human.get_ready
  end
end
