# frozen_string_literal: true

# require_relative '/lib/board'
# require_relative '/lib/player'

class Mastermind
  def initialize
    @board = []
    @guess = []
    @code = nil
    which_player
    play
  end

  def which_player
    loop do
      puts 'Who is the Player? 1 for You, 2 for the PC'
      @player = gets.chomp.to_i
      if @player != 1 || @player != 2 
        break
      end
    end
  end

  def play
    if @player == 1
      puts 'Generating code...'
      @code = rand(1000..9999)
    else
      loop do
        puts 'Submit a code between 1000 and 9999'
        @code = gets.chomp.to_i
        if @code.nil?
          puts 'Code must be 4 digits'
        elsif @code < 1000
          puts 'Code must be 4 digits, between 1000 and 9999'
        elsif @code > 9999
          puts 'Code must be 4 digits, between 1000 and 9999'
        else
          break
        end
      end
    end
    #// puts @code
    (i = 12).times do
      if i.positive?
        system "clear"
        showboard
        guessattempt
      end
    end
    puts "You're out of guesses!"
    exit
  end

  def showboard
    @board.each_with_index do |guesses, code_index|
      print @guess[code_index]
      print '|'
      puts guesses
    end
  end

  def guessattempt
    guess_temp = nil
    if @player == 1
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
    else
      guess_temp = pc_guesser.to_i
    end
    @guess << guess_temp
    guess_array = guess_temp.digits.reverse
    code_array = @code.digits.reverse
    guess_result = []
    # Iterates through each digit to eval match, mismatch, or miss
    guess_array.each_with_index do |digit, digit_index|
      code_array.each_with_index do |code_digit, code_digit_index|
        #// puts "Code: #{code_digit} Guess: #{digit}. Index code: #{code_digit_index} Index guess: #{digit_index}" # Console Logging
        if digit == code_digit && digit_index == code_digit_index
          guess_result << digit
          break
        elsif digit == code_digit && digit_index != code_digit_index
          if guess_array[digit_index] == code_array[digit_index] # ensure matching index doesnt have a match before declaring mismatch
           guess_result << digit
           break
          elsif guess_array[code_digit_index] == digit && code_digit_index > digit_index # there is a true match with the same digit on a higher index, return x
            guess_result << 'x'
            #// puts "Future true match"
          elsif guess_array.select{|e| e == digit}.length >= code_array.select{|e| e == digit}.length && 
              code_array.select{|e| e == digit} == guess_array.select.with_index{|e,i| e == digit && (guess_result[i] == '?' || guess_result[i] == digit)} #There is already a mismatch for this digit and the number of instances of this digit is met
            guess_result << 'x'
            #// puts "Reducing number of mismatches to equal to results in the code"
          else 
            guess_result << '?'
          end
          break
        end
      end
      guess_result << 'x' if guess_result.length == digit_index
      #// puts "Guess iteration: #{guess_result}" # Console Logging
    end
    @board << guess_result.join
    victory_check(guess_array,code_array)
  end

  def pc_guesser
    case @board.length
    when 0 
      1122
    when 1
      3456
    when 2
      7890
    when 3..13
      # placeholder until the guessing logic is implemented
      rand(1000..9999)
    else
      match_array = []
      imperfect_array = []
      imperfect_array_index = []
      @board.each_with_index do |guess, guess_index|
        match_array << guess.scan(/[0-9]/)
        puts "match_array: #{match_array}"
        # Get any mismatches, digit from @board at guess_index that match ? in @guess
        guess_array= guess.chars
        imperfect_array_index << guess_array.each_index.select{|i| guess_array[i] == '?'}.join.to_i
        # Match to @board entry digit and flatten
        puts "imperfect_array_index: #{imperfect_array_index}"
        imperfect_array_index.each_with_index do |board_index, digit_index|
          guess_chars = @guess[digit_index].digits.reverse
          puts "guess_chars: #{guess_chars}"
          #guess_chars = guess_chars.chars
          imperfect_array << guess_chars[board_index]
        end
        puts "imperfect_array: #{imperfect_array}"
      end
    end
  end

  def victory_check(guess_array,code_array)
    if guess_array == code_array
      system "clear"
      showboard
      puts "You Win!"
      exit
    end
  end
end

Mastermind.new
