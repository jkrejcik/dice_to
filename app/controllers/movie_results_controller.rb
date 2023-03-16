class MovieResultsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create_suggestion
  before_action :set_options, only: %i[question create_suggestion]
  before_action :colour, only: %i[create_suggestion question]
  # before_action :movie_result_params, only: :create_suggestion

  def question
    @movie_result = MovieResult.new
  end

  def create_suggestion
    genre = @colour_genre_key[params[:colour].to_sym]
    movie_candidates = Movie.where(genre: genre)
    raise

    year = params[:year].to_i..(params[:year].to_i + 10)
    movie_candidates = movie_candidates.where(year: year)

    mood = params[:mood]
    sql = @happy_words.map { "overview ilike ?" }.join(" or ")
    movie_candidates = movie_candidates.where(sql, *@happy_words) if mood == "happy"

    sql = @sad_words.map { "overview ilike ?" }.join(" or ")
    movie_candidates = movie_candidates.where(sql, *@sad_words) if mood == "sad"

    result = movie_candidates.sample
    redirect_to(movie_questions_path) and return if result.blank?

    if MovieResult.new(movie_id: result.id, user: current_user, time_taken: params[:time_taken])
      raise
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

  def set_options
    @movie_genres = Movie.pluck(:genre).uniq.sample(12)
    @years_for_select = [["70s", 1970], ["80s", 1980], ["90s", 1990], ["2000s", 2000], ["2010s", 2010], ["2020s", 2020]]
    @sad_words = ["%anger%", "%sad%", "%kill%", "%death%", "%fail%", "%cry%"]
    @happy_words = ["%happy%", "%success%", "%joy%", "%dog%", "%family%", "%love%"]
    @colours = ["blue", "green", "yellow", "red", "pink", "orange", "brown", "purple"]
  end

  def colour
    @colour_genre_key = {
      orange: "Animation",
      brown: "Adventure",
      pink: "Comedy",
      blue: "Drama",
      green: "Crime",
      red: "Horror",
      yellow: "Family",
      purple: "Action"
    }

    @colour_hash_key = {
      orange: "#FC7A57",
      brown: "#5C5346",
      pink: "#E56399",
      blue: "#5C78FF",
      green: "#01C97B",
      red: "#FF653E",
      yellow: "#FFCA14",
      purple: "#89608E"
    }
  end
end
