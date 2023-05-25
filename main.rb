# frozen_string_literal: true

# require_relative '/lib/board'
# require_relative '/lib/player'

class Mastermind
  def initialize
    @board = []
    @guess = []
    @code = nil
    play
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
    puts "You're out of guesses!"
    exit
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
    # Iterates through each digit to eval match, mismatch, or miss
    guess_array.each_with_index do |digit, digit_index|
      code_array.each_with_index do |code_digit, code_digit_index|
        puts "Code: #{code_digit} Guess: #{digit}. Index code: #{code_digit_index} Index guess: #{digit_index}" # Console Logging
        if digit == code_digit && digit_index == code_digit_index
          guess_result << digit
          next
        elsif digit == code_digit && digit_index != code_digit_index
          # ensure matching index doesnt have a match before declaring mismatch
          if guess_array[digit_index] == code_array[digit_index]
           guess_result << digit
           break
          end
          guess_result << '?'
          break
        end
      end
      guess_result << 'x' if guess_result.length == digit_index
      puts "Guess iteration: #{guess_result}" # Console Logging
    end
    @board << guess_result.join
    victory_check(guess_array,code_array)
  end

  def victory_check(guess_array,code_array)
    if guess_array == code_array
      showboard
      puts "You Win!"
      exit
    end
  end
end

Mastermind.new
