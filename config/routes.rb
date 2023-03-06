Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Routes for movie category
  get "movie-questions", to: "movie_results#question"
  post "movie-questions", to: "movie_results#create_suggestion"
  get "suggestion", to: "movie_results#show"
end
