class ResultsController < ApplicationController
  def index
    @movie_results = MovieResult.all.order('created_at ASC')
    @today = Time.now
  end

  def edit
  end

  def update
  end
end
