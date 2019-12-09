require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/human_player'

class HumanPlayerTest < Minitest::Test

  def test_things
    skip
    human = HumanPlayer.new
    human.get_ready
  end

  def test_send_fire_gives_valid_coordinate
    human = HumanPlayer.new
    my_coordinate = human.send_fire
    assert_equal true, human.board.valid_coordinate?(my_coordinate)
  end

  def test_it_can_receive_fire
    human = HumanPlayer.new
    assert_equal false, human.board.cells["B2"].fired_upon?
    human.receive_fire("B2")
    assert_equal true, human.board.cells["B2"].fired_upon?
    assert_equal "M", human.board.cells["B2"].render
  end
end
