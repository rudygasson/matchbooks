Rails.application.routes.draw do
  get 'meetings/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :copies, only: %i[index new create destroy]
  resources :books, only: %i[show]
  resources :users, only: %i[show destroy]
  resources :meetings, only: %i[index new create]
end
