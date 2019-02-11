class HangpersonGame
  attr_reader :word, :guesses, :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def word=(a)               # creates setter method for word
    @word = a
  end

  def guesses=(a)               # creates setter method for guesses
    @guesses = a
  end

  def wrong_guesses=(a)               # creates setter method for guesses
    @wrong_guesses = a
  end

  def guess(letter)
    if not letter =~ /[A-Za-z]/
      raise ArgumentError.new("")
    end
    if letter.upcase == letter
      return false
    end
    if word.include? letter
      if guesses.include? letter
        return false
      end
      @guesses += letter
    else
      if wrong_guesses.include? letter
        return false
      end
      @wrong_guesses += letter
    end
  end

  def word_with_guesses
    result = "-"*word.length
    for i in 0...word.length do
      if guesses.include? word[i]
        result[i] = word[i]
      end
    end
    return result
  end

  def check_win_or_lose
    if word_with_guesses == word
      return :win
    elsif guesses.length + wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end




  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
