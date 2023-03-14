class MovieResultsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create_suggestion
  before_action :set_genres, only: %i[question create_suggestion]
  # before_action :movie_result_params, only: :create_suggestion

  def question
  end

  def create_suggestion
    year = params[:year].to_i..(params[:year].to_i + 10)
    movie_candidates = Movie.where(year: year)

    genre = params[:genre]
    movie_candidates = movie_candidates.where(genre: genre)

    mood = params[:mood]
    happy_words = ["%happy%", "%success%", "%joy%", "%dog%", "%family%", "%love%"]
    sql = happy_words.map { "overview ilike ?" }.join(" or ")
    movie_candidates = movie_candidates.where(sql, *happy_words) if mood == "happy"
    
    sad_words = ["%anger%", "%sad%", "%kill%", "%death%", "%fail%", "%cry%"]
    sql = sad_words.map { "overview ilike ?" }.join(" or ")
    movie_candidates = movie_candidates.where(sql, *sad_words) if mood == "sad"
    
    result = movie_candidates.sample

    @movie_result = MovieResult.new(movie_id: result.id, user: current_user, time_taken: params[:time_taken])
    if @movie_result.save
      redirect_to suggestion_path
    else
      render "question"
    end
  end

  def show
    # Because we already saved in create_suggestion action result database we can use it here
    @movie_result = MovieResult.where(user: current_user).last
  end

  def index
    @movie_result = MovieResult.where(user: current_user).last
  end

  private

  def set_genres
    @movie_genres = Movie.pluck(:genre).uniq.sample(12)
    @years_for_select = [["70s", 1970], ["80s", 1980], ["90s", 1990], ["2000s", 2000], ["2010s", 2010], ["2020s", 2020]]
  end
end
