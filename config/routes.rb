Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "pages#home"

  resources :copies, only: %i[index new create destroy]
  resources :books, only: %i[show]
  resources :users, only: %i[show destroy]
  resources :meetings, only: %i[index new create]
end
