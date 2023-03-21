Rails.application.routes.draw do
  devise_for :users

  # Routes for pages
  root to: "pages#home"
  get "categories", to: "pages#category"

  # Routes for results of all rolls
  get "history", to: "results#index"
  get "history/:id/edit", to: "results#edit", as: :edit_history
  patch "history/:id", to: "results#update"

  # Routes for movie category
  get "movie-questions", to: "movie_results#question", as: :movie_questions
  post "movie-questions", to: "movie_results#create_suggestion"
  get "suggestion", to: "movie_results#show", as: :suggestion
  get "movie-accept", to: "movie_results#create"

  # Routes for custom process
  get "custom", to: "custom_results#new", as: :custom_results
  post "custom", to: "custom_results#create"
  get "custom/:id", to: "custom_results#show", as: :custom_result
  delete 'custom/:id', to: 'custom_results#destroy'
end
