class MovieResultsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create_suggestion
  before_action :set_movie, only: %i[show]
  before_action :set_options, only: %i[question create_suggestion]
  before_action :colour, only: %i[create_suggestion question]
  # before_action :movie_result_params, only: :create_suggestion

  def question
    @movie_result = MovieResult.new
  end

  def create_suggestion
    @result = Movie.all.sample
    @result = set_result if params[:colour] || params[:mood] || params[:decade] || params[:weather]

    redirect_to(movie_questions_path) and return if @result.blank?

    if MovieResult.create(movie_id: @result.id, user: current_user, time_taken: params[:time_taken])
      redirect_to movie_suggestion_path
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

  def set_result
    genre_candidates = set_genre_candidates
    year_candidates = set_year_candidates
    mood_candidates = set_mood_candidates

    @result = (genre_candidates + mood_candidates + year_candidates).sample
  end

  def set_genre_candidates
    genre = @colour_genre_key[params[:colour].to_sym] if params[:colour]
    genre ? Movie.where(genre: genre) : []
  end

  def set_year_candidates
    year = params[:decade].to_i..(params[:decade].to_i + 10) if params[:decade]
    year ? Movie.where(year: year) : []
  end

  def set_mood_candidates
    mood = params[:mood] if params[:mood]
    mood ? set_mood(mood) : []
  end

  def set_weather_candidates
    weather = params[:weather] if params[:weather]
    weather ? set_mood(mood) : []
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
    @movie_genres = ["Drama", "Comedy", "Animation", "Romance", "Fantasy", "Thriller",
                     "Western", "Adventure", "Action", "Horror", "Family", "Crime",
                     "Music", "History", "Science Fiction", "War"]
    @years_for_select = [["60s", 1960], ["70s", 1970], ["80s", 1980], ["90s", 1990], ["2000s", 2000], ["2010s", 2010], ["2020s", 2020]]
    @sad_words = ["%anger%", "%sad%", "%kill%", "%death%", "%fail%", "%cry%"]
    @happy_words = ["%happy%", "%success%", "%joy%", "%dog%", "%family%", "%love%"]
    @weather_words = [{ cloudy: ["%dark%", "%dreary%", "%grey%", "%overcase%"] }, { clear: ["%light%", "%day%"] },
                      { sunny: ["%sun%"] }, { rainy: ["%storm%", "%rain%", "%wet%", "%sea%"] }]
    @colours = ["blue", "green", "yellow", "red", "pink", "orange", "brown", "purple"]
    @sqlhappy = @happy_words.map { "overview ilike ?" }.join(" or ")
    @sqlsad = @sad_words.map { "overview ilike ?" }.join(" or ")
  end

  def colour
    @colour_genre_key = {
      orange: "Animation", brown: "Adventure", pink: "Comedy", blue: "Drama", green: "Crime",
      red: "Horror", yellow: "Family", purple: "Action", violet: "Romance", emerald: "Fantasy",
      grey: "Thriller", jasmine: "Music", myrtle: "History", navy: "Science Fiction", maroon: "War", cream: "Western"
    }
    @colour_hash_key = {
      orange: "#FC7A57", brown: "#5b4b49", pink: "#E56399", blue: "#5C78FF", green: "#01C97B",
      red: "#FF653E", yellow: "#FFCA14", purple: "#89608E", navy: "#19297C", myrtle: "#297373",
      cream: "#FFE5D4", grey: "#BDB4BF", violet: "#f0d3f7", emerald: "#26532B", jasmine: "#ffd972", maroon: "#92374d"
    }
  end
end
