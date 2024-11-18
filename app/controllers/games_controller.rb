require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @included = word_in_grid?(@word, @letters)
    @valid_word = valid_english_word?(@word)
  end

  def word_in_grid?(word, letters)
    word.chars.all? { |char| word.count(char) <= letters.count(char) }
  end

  def valid_english_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response = JSON.parse(URI.open(url).read)
    response['found']
  end
end
