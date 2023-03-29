class ReviewsController < ApplicationController
  def new
    @review = Review.nsew
  end

  def create
    @today = Time.now.utc
    @movie_result = MovieResult.find(params[:movie_result])
    @movie_result.rating = review_params[:rating]
    @movie_result.save

    respond_to do |format|
      format.html { redirect_to history_path }
      format.text { render partial: "results/movie_card", locals: { result: @movie_result }, formats: [:html] }
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating)
  end
end
