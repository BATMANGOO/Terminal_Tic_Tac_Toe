require_relative './player'
require_relative './board'

class Game 
  attr_reader :board, :first_player, :second_player, :current_player

  def initialize
    @board = Board.new
    @first_player = nil
    @second_player = nil
    @current_player = nil
  end

  def create_game
    combatents
    board.layout
    play_turns
    result
  end

  def create_player(number, duplicate_choice = nil)
    puts "Player ##{number}, what is your name?"
    name = gets.chomp.upcase
    choice = choice_input(duplicate_choice)
    Player.new(name, choice.downcase)
  end

  def turn(number)
    cell = turn_input(number)
    board.update_board(cell, current_player.choice)
    board.layout
  end

  def play_turns
    @current_player = first_player
    until board.full?
      puts "#{current_player.name} please pick a position on the board!"
      position = gets.chomp.to_i
      turn(position)
      break if board.game_over?

      @current_player = switch_players
    end
  end

  def combatents
    @first_player = create_player(1)
    @second_player = create_player(2, first_player.choice)
  end

  private

  def turn_input(choice)
    until board.valid_move?(choice)
      puts 'Invalid input, please choose another'
      choice = gets.chomp.to_i
      turn_input(choice)
    end
    choice
  end

  def choice_input(duplicate_choice)
    puts 'and your weapon of choice?'
    input = gets.chomp.downcase
    while input == duplicate_choice
      puts 'That weapon is taken, please choose another.'
      input = gets.chomp.downcase
    end
    input
  end

  def switch_players
    if current_player == first_player
      second_player
    else
      first_player
    end
  end

  def play_again?
    puts 'Would you like to play again? y or n?'
    input = gets.chomp.downcase
    if input == 'y'
      @board = Board.new
      create_game
    else
      puts 'Thanks for playing!'
    end
  end

  def result
    if board.game_over?
      puts "Yay #{current_player.name} has come out victorious!"
    else
      puts 'Tie game!'
    end
    play_again?
  end
end

game = Game.new
game.create_game
