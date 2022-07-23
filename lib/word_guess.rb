# frozen-string-literal: false

# A game of hangman
class WordGuess
  attr_reader :word, :guesses_remaining, :display, :letters_guessed

  TEXT = ['Pick a letter: ', 'Invalid input. Try again: '].freeze

  def initialize
    @word = random_word
    @guesses_remaining = 6
    @display = '_' * word.length
    @letters_guessed = []
    game_loop
  end

  def random_word(min = 5, max = 12)
    dictionary = File.open("dictionary.txt", 'r').readlines.map(&:chomp).select do |line|
      line.length.between?(min, max)
    end
    dictionary.sample
  end

  def display_previous_attempts
    puts display
    puts "Attempts remaining: #{guesses_remaining}"
    puts("Previous guesses: #{letters_guessed.join(', ')}.") if letters_guessed.length > 0
  end

  def prompt(text)
    print text
    gets.chomp.downcase
  end

  def get_guess
    guess = prompt(TEXT[0])
    prompt(TEXT[1]) until guess.between?('a','z')
    letters_guessed.push(guess)
    guess
    @guesses_remaining -= 1
  end

  def game_loop
    until guesses_remaining.zero? || display == word
      display_previous_attempts
      get_guess
    end
    game_over
  end

  def game_over
    result = ''
    if display == word
      result = "Congratulations! You guessed the word!"
    else
      @display == word
      result = "Oh no! The correct word was #{word}. You've lost!"
    end
    display_previous_attempts
    puts result
  end
end

puts 'Word Guess initialized.'
game = WordGuess.new
puts game.word
