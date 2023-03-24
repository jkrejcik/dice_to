Rails.application.routes.draw do
  devise_for :users

  # Routes for pages
  root to: "pages#home"
  get "categories", to: "pages#category"

  # Routes for results of all rolls
  get "history", to: "results#index"
  get "history/:id/edit", to: "results#edit", as: :edit_history
  patch "history/:id", to: "results#update"

  # Routes for movie category (WATCH)
  get "movie-questions", to: "movie_results#question", as: :movie_questions
  post "movie-questions", to: "movie_results#create_suggestion"
  get "movie-suggestion/:id", to: "movie_results#show", as: :movie_suggestion
  get "movie-accept", to: "movie_results#create"

  # Routes for custom process
  get "custom", to: "custom_results#new", as: :custom_results
  post "custom", to: "custom_results#create"
  get "custom/:id", to: "custom_results#show", as: :custom_result
  delete 'custom/:id', to: 'custom_results#destroy'

  # Routes for restaurant category (EAT)
  get "restaurant-questions", to: "restaurant_results#question", as: :restaurant_questions
  post "restaurant-questions", to: "restaurant_results#create_suggestion"
  get "restaurant-suggestion/:id", to: "restaurant_results#show", as: :restaurant_suggestion # can not be name only suggestion as it has to be unique route name
  # Did not create "restaurant-accept" route as it was not used in movies (we saved result already in create_suggestion)
end
