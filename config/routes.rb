Rails.application.routes.draw do
  devise_for :users

  # Routes for pages
  root to: "pages#home"
  get "categories", to: "pages#category"

  # Routes for movie category
  get "movie-questions", to: "movie_results#question"
  post "movie-questions", to: "movie_results#create_suggestion"
  get "suggestion", to: "movie_results#show"
  get "movie-accept", to: "movie_results#create"
end
