require './lib/computer_player'
require './lib/human_player'
require './lib/smart_computer'

class GameComputers
  attr_reader :computer, :human, :smart_computer

  def initialize
    @computer = ComputerPlayer.new
    @human = ComputerPlayer.new
  end

  def set_up
    @human.get_ready(10)
    @computer.get_ready(10)
    @smart_computer = SmartComputer.new(@human.board, @human.ships)
  end

  def main_menu
    system("clear")
    print_radical_title
    puts "Welcome to BATTLESHIP!"
    puts ""
    puts "Enter 'p' to play. Enter 'q' to quit."
    user_input = gets.chomp
    user_input.downcase
  end

  def take_turn(attacker, defender)
    print_boards
    coordinate = attacker.send_fire
    defender.receive_fire(coordinate)
    feedback(defender, coordinate)
  end

  def feedback(defender, coordinate)
    char = defender.board.cells[coordinate].render
    print $hit if char == $H
    print $miss if char == $M
    print $sunk if char == $X
    sleep(0.1)
  end

  def game_over?
    if @human.ships.all?{ |ship| ship.sunk?}
      print_final_boards
      puts "Smart CPU won!"
      gets.chomp
      return true
    end
    if @computer.ships.all? { |ship| ship.sunk? }
      print_final_boards
      puts "Random CPU won!"
      gets.chomp
      return true
    end
    false
  end

  def run
    choice = main_menu
    until (choice == "q")
      if choice == "p"
        set_up
        until game_over?
          take_turn(@human, @computer)
          break if game_over?
          take_turn(@smart_computer, @human)
        end
        choice = main_menu
      else
        choice = main_menu
      end
    end
    system("clear")
    puts $white_bold + "\n\n                  T H A N K S   F O R   P L A Y I N G  ! ! !" + $color_restore
    print_sweet_ship
  end

  def print_boards
    system('clear')
    @computer.print_board
    @human.print_board
  end

  def print_final_boards
    system('clear')
    @computer.print_board(true)
    @human.print_board
  end

  def print_radical_title
    puts ''
    puts '    888             888   888   888                888     d8b'
    puts '    888             888   888   888                888     Y8P'
    puts '    888             888   888   888                888                 '
    puts '    88888b.  8888b. 888888888888888 .d88b. .d8888b 88888b. 88888888b.  '
    puts '    888 "88b    "88b888   888   888d8P  Y8b88K     888 "88b888888 "88b '
    puts '    888  888.d888888888   888   88888888888"Y8888b.888  888888888  888 '
    puts '    888 d88P888  888Y88b. Y88b. 888Y8b.         X88888  888888888 d88P '
    puts '    88888P" "Y888888 "Y888 "Y888888 "Y8888  88888P 888  88888888888P"  '
    puts '                                                              888      '
    puts '                                                              888      '
    puts '                                                              888   '
    puts ""
  end

  def print_sweet_ship
    puts $cyan + ""
    puts "                                     # #  ( )"
    puts "                                  ___#_#___|__"
    puts "                              _  |____________|  _"
    puts "                       _=====| | |            | | |==== _"
    puts "                 =====| |.---------------------------. | |===="
    puts "   <--------------------'   .  .  .  .  .  .  .  .   '--------------/"
    puts "     \\                                                             /"
    puts "      \\_______________________________________________WWW_________/"
    puts "  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"
    puts "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"
    puts "   wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww "
    puts $color_restore + "\n\n"
  end

end