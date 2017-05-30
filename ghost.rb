# yet to be added -> AI , display current fragment before guess , display rounds played and guesses. , Respond to players by name, use optional(and default) dictionaries.

class Game
  attr_reader :dictionary
  attr_accessor :players , :fragment, :counter , :rounds
  def initialize(p1,p2)
    @fragment=''
    @players=[Player.new(p1),p2 = Player.new(p2)]
    @dictionary=File.readlines('dictionary.txt').map(&:chomp)
    @counter = 0
    @rounds=0
  end

  def play_round(guess)
    @fragment = @fragment + guess
  end

  def current_player
    @players[0]
  end

  def previous_player
    @players[1]
  end

  def next_player!
    self.current_player, self.previous_player = self.previous_player , self.current_player
  end

  def take_turn(player)
    puts "#{player}'s turn"
    until valid_play(@guess)
      play_round(@guess)
    end
    @counter += 1
    lose?
    next_player!
  end

  def lose?
    if @dictionary.any? { |word| word == @fragment }
      puts "Game Over. #{current_player} loses."
      @fragment = ""
      @rounds+=1
    end

  end

  def valid_play?(string)
    unless ('a'..'z').include?(string) && string.length == 1
      current_player.alert_invalid_guess
    end
    @dictionary.any? do |word|
      word.include?(@fragment+string)
    end
  end
end

class Player
  def initialize(name)
    @player=name
    @guess
  end

  def guess
    puts "Guess a letter"
    @guess = gets.chomp
  end

  def alert_invalid_guess
    puts "Invalid Guess"
    guess
  end
end
