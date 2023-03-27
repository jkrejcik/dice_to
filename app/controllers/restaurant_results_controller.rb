class RestaurantResultsController < ApplicationController
  before_action :set_restaurant, only: %i[show]
  before_action :colour, only: %i[question create_suggestion]
  before_action :set_options, only: %i[question]

  def question
    @restaurant_result = RestaurantResult.new
  end

  def create_suggestion
    @result = set_result if params[:colour] || params[:mood] || params[:decade] || params[:weather] || params[:star]
    @result = Restaurant.all.sample if @result.nil?

    RestaurantResult.create(restaurant_id: @result.id, user: current_user, time_taken: params[:time_taken])
    redirect_to restaurant_suggestion_path((RestaurantResult.where(user: current_user).last))

  end

  def show
    @restaurant_result = RestaurantResult.find(params[:id])
  end

  def index
  end

  def update
    @restaurant_result = RestaurantResult.find(params[:id])
    case params[:commit]
    when "Accept"
      @restaurant_result.accepted = true
      @restaurant_result.time_taken = params[:time_taken]
      redirect_to restaurant_suggestion_path(@restaurant_result) if @restaurant_result.save
    when "Reject"
      redirect_to restaurant_questions_path if @restaurant_result.delete
    end
  end

  private

  def set_result
    cuisine_candidates = set_cuisine_candidates
    # year_candidates = set_year_candidates
    # mood_candidates = set_mood_candidates
    # weather_candidates = set_weather_candidates
    star_candidates = set_star_candidates

    # (cuisine_candidates + mood_candidates + year_candidates + weather_candidates + star_candidates).sample
    (cuisine_candidates + star_candidates).sample
  end

  def set_star_candidates
    star_sign = params[:star] if params[:star]
    star_sign ? star_sign(star_sign) : []
  end

  def star_sign(star_sign)
    first_letter = star_sign[0]
    Restaurant.where("title ilike '#{first_letter}%'")
  end

  def set_restaurant
    @restaurant_result = RestaurantResult.where(user: current_user).last
  end

  def set_options
    @restaurant_cuisines = []
    @years_for_select = [["60s", 1960], ["70s", 1970], ["80s", 1980], ["90s", 1990], ["2000s", 2000], ["2010s", 2010], ["2020s", 2020]]
  end

  def set_cuisine_candidates
    cuisine = @colour_cuisine_key[params[:colour].to_sym] if params[:colour]
    cuisine ? Restaurant.where(cuisine: cuisine) : []
  end

  def colour
    @colour_cuisine_key = {
      orange: "Chinese", brown: "Mexican", pink: "Jamaican", blue: "Drama", green: "Italian",
      red: "Taiwanese", yellow: "Spanish", purple: "French", violet: "German", emerald: "Eritrean",
      grey: "Russian", jasmine: "Japanese", myrtle: "Greek", navy: "Vietnamese", maroon: "Polish", cream: "American"
    }
    @colour_hash_key = {
      orange: "#FC7A57", brown: "#5b4b49", pink: "#E56399", blue: "#5C78FF", green: "#01C97B",
      red: "#FF653E", yellow: "#FFCA14", purple: "#89608E", navy: "#19297C", myrtle: "#297373",
      cream: "#FFE5D4", grey: "#BDB4BF", violet: "#f0d3f7", emerald: "#26532B", jasmine: "#ffd972", maroon: "#92374d"
    }
  end
end
