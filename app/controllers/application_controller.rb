class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :total_decisions
  before_action :total_time_saved

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def total_decisions
    @total_decisions = RestaurantResult.count + MovieResult.count + CustomResult.count
  end

  def total_time_saved
    @total_time_saved = 0
    MovieResult.all.each do |movie_result|
      @total_time_saved += movie_result.time_taken.to_i
    end
    RestaurantResult.all.each do |restaurant_result|
      @total_time_saved += restaurant_result.time_taken.to_i
    end
    @total_time_saved /= 60
  end
end
