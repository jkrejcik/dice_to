class MovieResultsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create_suggestion
  before_action :set_movie, only: %i[show index]
  before_action :set_options, only: %i[question create_suggestion]
  before_action :colour, only: %i[create_suggestion question]
  # before_action :movie_result_params, only: :create_suggestion

  def question
    @movie_result = MovieResult.new
  end

  def create_suggestion
    result = Movie.all.sample
    genre = @colour_genre_key[params[:colour].to_sym] if params[:colour]
    genre ? genre_candidates = Movie.where(genre: genre) : []

    year = params[:decade].to_i..(params[:decade].to_i + 10) if params[:decade]
    year ? year_candidates = Movie.where(year: year) : []

    mood = params[:mood] if params[:mood]
    mood_candidates = set_mood(mood) if mood
    result = (genre_candidates + mood_candidates + year_candidates).sample if (genre_candidates + mood_candidates + year_candidates).count.positive?

    redirect_to(movie_questions_path) and return if result.blank?

    if MovieResult.create(movie_id: result.id, user: current_user, time_taken: params[:time_taken])
      redirect_to suggestion_path
    else
      render "question"
    end
  end

  def show
  end

  def index
  end

  private

  def set_movie
    @movie_result = MovieResult.where(user: current_user).last
  end

  def set_mood(mood)
    case mood
    when "happy"
      Movie.where(@sqlhappy, *@happy_words)
    when "sad"
      Movie.where(@sqlsad, *@sad_words)
    when "neutral"
      []
    when "bad"
      []
    else
      []
    end
  end

  def set_options
    @movie_genres = Movie.pluck(:genre).uniq.sample(12)
    @years_for_select = [["60s", 1960], ["70s", 1970], ["80s", 1980], ["90s", 1990], ["2000s", 2000], ["2010s", 2010], ["2020s", 2020]]
    @sad_words = ["%anger%", "%sad%", "%kill%", "%death%", "%fail%", "%cry%"]
    @happy_words = ["%happy%", "%success%", "%joy%", "%dog%", "%family%", "%love%"]
    @colours = ["blue", "green", "yellow", "red", "pink", "orange", "brown", "purple"]
    @sqlhappy = @happy_words.map { "overview ilike ?" }.join(" or ")
    @sqlsad = @sad_words.map { "overview ilike ?" }.join(" or ")
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
