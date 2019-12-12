require './lib/computer_player'
require './lib/human_player'
require './lib/smart_computer'
require './lib/ship'
require_relative 'color_palette'

class Game
  def initialize
    @computer = ComputerPlayer.new("CPU")
    @human = HumanPlayer.new("PLAYER")
    @game_speed = 0.2
  end

  def set_options
    puts ""
    print "Enter 'd' for default (4x4), 'c' for classic (10x10),"\
      " 'u' for custom board: "
    choice = gets.chomp.downcase
    until (choice == 'd' || choice == 'c' || choice == 'u')
      choice = gets.chomp.downcase
    end
    set_default if choice == 'd'
    set_classic if choice == 'c'
    set_custom if choice == 'u'
    puts ""
    print "Select game speed: '1' for slow, '2' for medium, '3' for fast"\
      " '4' for hyper, '!' for !?: "
    choice = gets.chomp.downcase
    until (choice.length == 1 && "1234!".include?(choice))
      choice = gets.chomp.downcase
    end
    @game_speed = 2 if choice == '1'
    @game_speed = 1 if choice == '2'
    @game_speed = 0.3 if choice == '3'
    @game_speed = 0.06 if choice == '4'
    @game_speed = 0 if choice == '!'
  end

  def set_up
    @human.get_ready
    @smart_computer = SmartComputer.new(@human.board, @human.ships)
    smart_mode_on
    @computer.get_ready
  end

  def set_default
    @computer.set_default
    @human.set_default
  end

  def set_classic
    @computer.set_classic
    @human.set_classic
  end

  def set_custom
    ships = []
    puts "\nMake a custom board. WARNING: It's possible to break the game.\n"
    print "\nEnter board length: "
    size = gets.chomp.to_i
    until (size > 0 && size <= 26)
      print "Too big. " if size > 26
      print "Try again: "
      size = gets.chomp.to_i
    end
    print "\nEnter number of ships: "
    number_of_ships = gets.chomp.to_i
    until (number_of_ships.to_i > 0)
      print "Try again: "
      number_of_ships = gets.chomp.to_i
    end
    puts "\nCreate your ships. Invalid lengths will delete the ship."
    number_of_ships.times do |index|
      puts ""
      print "Enter ship name ##{index + 1}: "
      name = gets.chomp
      puts ""
      print "Enter #{name} length: "
      length = gets.chomp.to_i
      if (length > 0 && length <= size)
        ship = Ship.new(name, length)
        ships << ship
      else
        puts "\nInvalid length. Cancelling #{name}"
      end
    end
    if ships.empty?
      puts "\nFailed to make ships. Starting default game...\n\n"
      set_default
    else
      puts "\nStarting custom game...\n\n"
      @human.set_custom(size, ships)
      @computer.set_custom(size, ships)
      @human.press_enter_to_continue
    end
  end

  def set_human_to_computer
    @human = ComputerPlayer.new("CPU2")
  end

  def set_human
    @human = HumanPlayer.new("PLAYER")
  end

  def smart_mode_on
    @computer.smart_ai = @smart_computer
  end

  def smart_mode_off
    @computer.smart_ai = nil
  end

  def main_menu
    system("clear")
    print_radical_title
    puts "Welcome to " + $white_bold + "BATTLESHIP!" + $color_restore
    puts ""
    print "Enter 'p' to play, enter 'c' to play CPU war, 'q' to quit: "
    user_input = gets.chomp
    user_input.downcase
    if user_input == 'c'
        set_human_to_computer
      return 'p'
    end
    if user_input == 'p'
        set_human
      return 'p'
    end
    user_input
  end

  def take_turn(attacker, defender)
    print_boards
    coordinate = attacker.send_fire
    sleep(@game_speed)
    defender.receive_fire(coordinate)
    feedback(defender, coordinate)
  end

  def feedback(defender, coordinate)
    char = defender.board.cells[coordinate].render
    print $hit if char == $H
    print $miss if char == $M
    print $sunk if char == $X
    sleep(@game_speed * 2)
  end

  def game_over?
    if @human.ships.all?{ |ship| ship.sunk?}
      print_boards(true)
      puts $red_bold + "#{@computer.name} won!" + $color_restore
      @human.press_enter_to_continue
      return true
    end
    if @computer.ships.all? { |ship| ship.sunk? }
      print_boards(true)
      puts $white_bold + "#{@human.name} won!" + $color_restore
      @human.press_enter_to_continue
      return true
    end
    false
  end

  def run
    choice = main_menu
    until (choice == "q")
      if choice == "p" || choice == "c"
        set_options
        puts ""
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
    system("clear")
    puts $white_bold + "\n\n                  T H A N K S   F O R "\
    "  P L A Y I N G  ! ! !" + $color_restore
    print_sweet_ship
  end

  def print_boards(reveal = false)
    system('clear')
    @computer.print_board(reveal)
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
