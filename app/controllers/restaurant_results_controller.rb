class RestaurantResultsController < ApplicationController
  before_action :set_restaurant, only: %i[show]
  before_action :colour, only: %i[question]
  before_action :set_options, only: %i[question]

  def question
    @restaurant_result = RestaurantResult.new
  end

  def create_suggestion
    @result = Restaurant.all.sample

    redirect_to(restaurant_questions_path) and return if @result.blank?

    if RestaurantResult.create(restaurant_id: @result.id, user: current_user, time_taken: params[:time_taken])
      redirect_to restaurant_suggestion_path
    else
      raise
      render "question"
    end
  end

  def show
  end

  def index
  end

  private

  def set_restaurant
    @restaurant_result = RestaurantResult.where(user: current_user).last
  end

  def set_options
    @years_for_select = [["60s", 1960], ["70s", 1970], ["80s", 1980], ["90s", 1990], ["2000s", 2000], ["2010s", 2010], ["2020s", 2020]]
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
