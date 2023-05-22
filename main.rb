# frozen_string_literal: true

# require_relative '/lib/board'
# require_relative '/lib/player'

class Mastermind
  def initialize
    @board = []
    @guess = []
    @code = nil
    play
    # showboard
  end

  def play
    puts 'Generating code...'
    @code = rand(1000..9999)
    puts @code
    (i = 12).times do
      if i.positive?
        guessattempt
        showboard
      end
    end
  end

  def showboard
    @board.each_with_index do |code, code_index|
      print @guess[code_index]
      print '|'
      puts code
    end
  end

  def guessattempt
    guess_temp = nil
    loop do
      puts 'Please enter a guess'
      guess_temp = gets.chomp.to_i
      if guess_temp.nil?
        puts 'Guess must be 4 digits'
      elsif guess_temp < 1000
        puts 'Guess must be 4 digits, between 1000 and 9999'
      elsif guess_temp > 9999
        puts 'Guess must be 4 digits, between 1000 and 9999'
      else
        break
      end
    end
    @guess << guess_temp
    guess_array = guess_temp.digits.reverse
    code_array = @code.digits.reverse
    guess_result = []
    code_array.each_with_index do |code_digit, code_digit_index| # Iterates through each digit to eval match, mismatch, or miss
      guess_array.each_with_index do |digit, digit_index|
        puts "Code: #{code_digit} Guess: #{digit}"
        if digit == code_digit && digit_index == code_digit_index
          guess_result << digit
        elsif digit == code_digit
          guess_result << '?'
        end
      end
      guess_result << 'x' if guess_result.length == code_digit_index
      puts "Guess iteration: #{guess_result}"
    end
    @board << guess_result.join
  end
end

Mastermind.new
