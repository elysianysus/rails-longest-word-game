require 'json'
require 'rest-client'


class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    ## ["l", "q", "k", "y", "s", "t", "z", "a", "o", "g"]
  end

  def score
    @answer = params[:guess]
    formated_answer = params[:guess].downcase.split('')
    @letters = params[:letters]

    def validating_word
      response = RestClient.get("https://wagon-dictionary.herokuapp.com/#{@answer}")
      results = JSON.parse(response)
      new_results = results['found']
    end

    if formated_answer.all? { |letter| @letters.include?(letter) } == false
      @score = "Sorry, but #{params[:guess]} can't be built from the given letters: #{@letters}."
    elsif validating_word == false
      @score = "Sorry, but #{params[:guess]} does not seem to be a valid English word..."
    else
      @score = "Congratulations! #{params[:guess]} is a valid English word!"
    end
  end
end
