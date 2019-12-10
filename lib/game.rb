class Game
  attr_reader :computer, :human

  def initialize
    @computer = ComputerPlayer.new
    @human = HumanPlayer.new
  end

  def set_up
    @human.get_ready
    @computer.get_ready
  end

  def main_menu
    system("clear")
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    user_input = gets.chomp
    user_input.downcase
  end

  def take_turn(attacker, defender)
    print_boards
    defender.receive_fire(attacker.send_fire)
  end

  def game_over?
    if @human.ships.all?{ |ship| ship.sunk?}
      print_boards
      puts "I won!"
      @human.press_enter_to_continue
      return true
    end
    if @computer.ships.all? { |ship| ship.sunk? }
      print_boards
      puts "You won!"
      @human.press_enter_to_continue
      return true
    end
    false
  end

  def run_game
    choice = main_menu
    until (choice == "q")
      if choice == "p"
        set_up
        until game_over?
          take_turn(@human, @computer)
          break if game_over?
          take_turn(@computer, @human)
        end
        choice = main_menu
      else
        choice = main_menu
      end
    end
  end

  def print_boards
    system('clear')
    @computer.print_board
    @human.print_board
  end

end
