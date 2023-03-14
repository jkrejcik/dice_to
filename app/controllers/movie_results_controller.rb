class MovieResultsController < ApplicationController
  def question
  end

  def create_suggestion
    # Creating new empty instance of MovieResult
    @result = MovieResult.new

    # checkboxes
    @question_genre1 = params[:question_genre1] # Action
    @question_genre2 = params[:question_genre2] # Comedy

    # radio box
    @question_mood = params[:question_mood]

    # Magic formula to pick a movie based on answers
    # This example finds 3 movies objects and store them in @movie_suggestion
    # Rest of params data is not used for simplicity
    @movie_suggestion = Movie.where(genre: @question_genre1)

    # Giving user_id + movie_id to @result
    @result.user = current_user

    # As @movie_suggestion was array (.sample) picks random object Movie
    @result.movie = @movie_suggestion.sample
    @result.rating = rand(1..5)

    # If succesfully saved ("Action" checkbox has to be clicked) user is redirected to /suggestion page (internaly show.html.erb)
    if @result.save
      redirect_to suggestion_path
    else
      render "question"
    end
  end

  def show
    # Because we already saved in create_suggestion action result database we can use it here
    @movie_result = MovieResult.find(params[:id])
  end

  def index
    @movie_genres = Movie.pluck(:genre).uniq.sample(12)
    @years_for_select = [["70s",1970],["80s",1980],["90s",1990],["2000s",2000], ["2010s",2010], ["2020s",2020]]
  end

  def create
    year = params[:year].to_i..(params[:year].to_i + 10)
    movie_candidates = Movie.where(year: year)

    genre = params[:genre]
    movie_candidates = movie_candidates.where(genre: genre)

    mood = params[:mood]
    happy_words = ["%happy%", "%success%", "%joy%", "%dog%", "%family%", "%love%"]
    sql = happy_words.map {"overview ilike ?"}.join(" or ")
    movie_candidates = movie_candidates.where(sql, *happy_words) if mood=="happy"
    sad_words = ["%anger%", "%sad%", "%kill%", "%death%", "%fail%", "%cry%"]
    sql = sad_words.map {"overview ilike ?"}.join(" or ")
    movie_candidates = movie_candidates.where(sql, *sad_words) if mood=="sad"
    result = movie_candidates.sample
    redirect_to(movie_results_path) and return if result.blank?
    movie_result = MovieResult.create(movie_id: result.id, user_id: current_user.id)
    redirect_to movie_result_path(movie_result)
  end
end
