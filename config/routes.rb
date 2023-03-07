Rails.application.routes.draw do
  get 'results/index'
  get 'results/edit'
  get 'results/update'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"



  # Routes for results of all rolls
  get "history", to: "results#index"
  get "history/:id/edit", to: "results#edit", as: :edit_history
  patch "history/:id", to: "results#update"
end
