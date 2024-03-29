class ResultsController < ApplicationController
  def index
    @review = Review.new
    @movie_results = MovieResult.all.order('created_at DESC').where(user: current_user)
    @restaurant_results = RestaurantResult.all.order('created_at DESC').where(user: current_user)
    @custom_results = CustomResult.all.order('created_at DESC').where(user: current_user)
    @today = Time.now.utc
  end

  def edit
  end

  def update
  end
end
