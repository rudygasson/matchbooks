Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "pages#home"
  post "/search", to: "pages#search"

  resources :copies, only: %i[index new create destroy]
  resources :books, only: %i[show]
  resources :users, only: %i[show destroy]
  resources :meetings, only: %i[index show new create] do
    resources :messages, only: %i[create]
  end
  get "/meetings/:id/confirm", to: "meetings#confirm", as: "confirm_meeting"
  get "/meetings/:id/cancel", to: "meetings#cancel", as: "cancel_meeting"
end
