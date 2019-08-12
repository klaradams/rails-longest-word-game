require 'open-uri'

class GamesController < ApplicationController
  def new
    range = ('A'..'Z').to_a.flatten
    @array = (0...10).map { range[rand(range.length)] }
    @answer = params[:answer]
  end

  def score
    @answer = params[:answer]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"

    response = open(url).read
    item = JSON.parse(response)
    @array = params["array"]
    answer_array = @answer.upcase.chars
    if item["found"] == true && (answer_array - @array.delete('').chars).empty?
      @output = "Word is valid!"
      @score = answer_array.length
    else
      @output = "Word is invalid! Please try again!"
      @score = 0
    end

    # if (answer_array - @array.delete('').chars).empty?
    #   @result = 'yes'
    # else
    #   @result = 'no'
    # end

    # if answer_array.each.in?(@array) == true
    #   @result = 'yes'
    # else
    #   @result = 'no'
    # end
    # raise
    # render plain: "Your answer: #{@answer}. #{@output} -- #{@array}#{answer_array}#{@result}"
  end
end
