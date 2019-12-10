class Game
  attr_reader :computer, :human

  def initialize
    @computer = ComputerPlayer.new
    @human = HumanPlayer.new
  end

  def set_up
    @computer.get_ready
    @human.get_ready
  end

  def take_turn(attacker, defender)
    print_boards
    defender.receive_fire(attacker.send_fire)
  end

  def game_over?
    if @human.ships.all?{ |ship| ship.sunk?}
      puts "I won!"
      return true
    end
    if @computer.ships.all? { |ship| ship.sunk? }
      puts "You won!"
      return true
    end
    false
  end

  def run_game
    set_up
    until game_over?
      take_turn(@human, @computer)
      break if game_over?
      take_turn(@computer, @human)
    end
  end

  def print_boards
    system('clear')
    @computer.print_board
    @human.print_board
  end

end
