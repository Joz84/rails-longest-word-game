class PlayingController < ApplicationController
  def game
    session[:start_time] = Time.now
    session[:grid] = Game.grid(9)
    @grid = session[:grid]

  end

  def score
    end_time = Time.now
    start_time = session[:start_time].to_time
    @attempt = params[:word]
    @grid = session[:grid]
    @result = Game.new(@attempt, @grid, start_time, end_time).result
  end
end
