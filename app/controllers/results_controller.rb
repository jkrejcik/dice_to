class ResultsController < ApplicationController
  def index
    @movie_results = MovieResult.all.order('created_at DESC')
    @custom_results = CustomResult.all.order('created_at DESC')
    @today = Time.now.utc
  end

  def edit
  end

  def update
  end
end
