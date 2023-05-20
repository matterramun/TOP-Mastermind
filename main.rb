# frozen_string_literal: true

#require_relative '/lib/board'
#require_relative '/lib/player'

class Mastermind
  def initialize
    @board = []
    @guess = []
    @code = nil
    play
    showboard
  end

  def showboard
    @board.each_with_index do |code, _code_index|
      print @guess[_code_index]
      print '|'
      puts code
    end
  end

  def play
    puts 'Generating code...'
    @code = rand(1000..9999)
    puts @code
    (i=12).times do |i|
        if i > 0
          puts "What is your guess?"
          @guess << gets.chomp.to_i
          showboard
        #elsif

        end
    end
  end

end

Mastermind.new