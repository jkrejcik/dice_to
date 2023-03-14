class MovieResultsController < ApplicationController
  def question
  end

  def create_suggestion
    # Creating new empty instance of MovieResult
    @result = MovieResult.new

    # After user clicks Roll (form submit button) values from params are send here
    @question_text = params[:question_text]

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
    @movie_result = MovieResult.where(user: current_user).last
  end

  def create
  end
end
