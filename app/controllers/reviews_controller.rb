class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new
    @movie_result = MovieResult.find(params[:movie_result])
    @movie_result.rating = review_params[:rating]
    # @review = Review.new(review_params[:review])
    if @movie_result.save
      redirect_to history_path(@movie_result, anchor: "movie_result_#{@review}")
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :movie_result)
  end
end
