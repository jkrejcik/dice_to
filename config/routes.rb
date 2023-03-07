Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # resources :custom_results, path: '/custom_results/new'
  get "custom", to: "custom_results#new", as: :custom_results

end