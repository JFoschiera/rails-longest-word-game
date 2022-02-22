require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    if include?
      if english_word?
        @result = `Congratilations! #{params[:word]} is a valid word and you won!`
      else
        @result = `Sorry but #{params[:word]} is not valid english word`
      end
    else
      @result = `Sorry but #{params[:word]} can't be built out of the original grid.`
    end
  end

  def include?
    @letters = params[:letter].split('')
    @user_word = params[:word]
    @user_word.chars.all? { |letter| @user_word.count(letter) <= @letters.count(letter) }
  end

  def english_word?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    @words_found = json['found']
  end
end
