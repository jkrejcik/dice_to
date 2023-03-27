class RestaurantResultsController < ApplicationController
  # before_action :set_restaurant, only: %i[show]
  before_action :colour, only: %i[question create_suggestion]
  # before_action :set_options, only: %i[question]

  def question
    @restaurant_result = Restaurant.new
  end

  def create_suggestion
    @restaurant_result = Restaurant.new
    @client = GooglePlaces::Client.new(ENV.fetch('GOOGLE_API'))
    coordinates = params[:coordinates].split(",")
    latitude = coordinates[0]
    longitude = coordinates[1]

    if params[:colour]
      cuisine = @colour_cuisine_key[params[:colour].to_sym]
    else
      items = @colour_cuisine_key.values
      cuisine = items[rand(items.length)]
    end

    restaurant = @client.spots(latitude, longitude, :name => cuisine, :types => 'restaurant', :radius => 500, :detail => true).sample

    @restaurant_result.name = restaurant.name
    @restaurant_result.city = restaurant.city
    @restaurant_result.cuisine = cuisine
    @restaurant_result.address = restaurant.formatted_address
    @restaurant_result.phone = restaurant.formatted_phone_number
    @restaurant_result.rating = restaurant.rating
    @restaurant_result.price = restaurant.price_level

    if restaurant.photos.empty?
      @restaurant_result.image_1 = "https://source.unsplash.com/random?restaurant"
      @restaurant_result.image_2 = "https://source.unsplash.com/random?restaurant"
      @restaurant_result.image_3 = "https://source.unsplash.com/random?restaurant"
    elsif restaurant.photos.size == 1
      @restaurant_result.image_1 = restaurant.photos[0].fetch_url(800)
      @restaurant_result.image_2 = "https://source.unsplash.com/random?restaurant"
      @restaurant_result.image_3 = "https://source.unsplash.com/random?restaurant"
    elsif restaurant.photos.size == 2
      @restaurant_result.image_1 = restaurant.photos[0].fetch_url(800)
      @restaurant_result.image_2 = restaurant.photos[1].fetch_url(800)
      @restaurant_result.image_3 = "https://source.unsplash.com/random?restaurant"
    elsif restaurant.photos.size >= 3
      @restaurant_result.image_1 = restaurant.photos[0].fetch_url(800)
      @restaurant_result.image_2 = restaurant.photos[1].fetch_url(800)
      @restaurant_result.image_3 = restaurant.photos[2].fetch_url(800)
    end
    @restaurant_result.save

    RestaurantResult.create(restaurant_id: @restaurant_result.id, user: current_user, time_taken: params[:time_taken])
    redirect_to restaurant_suggestion_path(RestaurantResult.last)
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
    # cuisine_candidates = set_cuisine_candidates
    # # year_candidates = set_year_candidates
    # # mood_candidates = set_mood_candidates
    # # weather_candidates = set_weather_candidates
    # star_candidates = set_star_candidates

    # # (cuisine_candidates + mood_candidates + year_candidates + weather_candidates + star_candidates).sample
    # (cuisine_candidates + star_candidates).sample
  end

  def set_star_candidates
    # star_sign = params[:star] if params[:star]
    # star_sign ? star_sign(star_sign) : []
  end

  def star_sign(star_sign)
    # first_letter = star_sign[0]
    # Restaurant.where("title ilike '#{first_letter}%'")
  end

  def set_restaurant
    # @restaurant_result = RestaurantResult.where(user: current_user).last
  end

  def set_options
    # @restaurant_cuisines = []
    # @years_for_select = [["60s", 1960], ["70s", 1970], ["80s", 1980], ["90s", 1990], ["2000s", 2000], ["2010s", 2010], ["2020s", 2020]]
  end

  def set_cuisine_candidates
    # cuisine = @colour_cuisine_key[params[:colour].to_sym] if params[:colour]
    # cuisine ? Restaurant.where(cuisine: cuisine) : []
  end

  def colour
    @colour_cuisine_key = {
      orange: "French", brown: "Chinese", pink: "Chinese", blue: "Italian", green: "Greek",
      red: "Spanish", yellow: "Lebanese", purple: "Turkey", violet: "Thai", emerald: "Indian",
      grey: "Mexican", jasmine: "American"
    }
    @colour_hash_key = {
      orange: "#FC7A57", brown: "#5b4b49", pink: "#E56399", blue: "#5C78FF", green: "#01C97B",
      red: "#FF653E", yellow: "#FFCA14", purple: "#89608E", grey: "#BDB4BF", violet: "#f0d3f7",
      emerald: "#26532B", jasmine: "#ffd972"
    }
  end
end
