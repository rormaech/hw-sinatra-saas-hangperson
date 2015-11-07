class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses =''
  end


  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  
  def guess(new_guess)
    raise ArgumentError, "New guess is nil" if new_guess.nil?
    raise ArgumentError, "New guess is empty" if new_guess == ''
    raise ArgumentError, "New guess is not a letter" unless new_guess =~ /[[:alpha:]]/
    
    new_guess.downcase!
    
    if @guesses.include? new_guess 
      return false  
    elsif @wrong_guesses.include? new_guess 
      return false  
    else
      if @word.include? new_guess
        @guesses += new_guess
        return true  
      else
        @wrong_guesses += new_guess
        return true
      end
    end
  end
  
  
  def word_with_guesses
    disp=''
    @word.each_char do 
      |letter|
      if @guesses.to_s.include? letter
        disp += letter
      else
        disp += '-'
      end
    end
    return disp
  end
  
  
  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    elsif @guesses.length == @word.split(//).uniq.length
      return :win
    else
      return :play
    end
  end
    
end
