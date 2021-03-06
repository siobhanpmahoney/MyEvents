Rails.application.routes.draw do
  resources :categories
  resources :users
  resources :venues
  resources :events
  resources :attractions

  get 'tickets/guest', to: 'tickets#new_w_guest'
  post 'tickets/guest', to: 'tickets#create_w_guest'

  resources :tickets, only: [:new, :create, :show]

  root to: "welcome#home"

  get 'search', to: 'search#results'
  post 'search', to: 'search#results'

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "signup", to: "users#new"
  delete "logout", to: "sessions#destroy"

  get "music_events", to: "categories#music_events"
  get "sports_events", to: "categories#sports_events"
  get "arts_events", to: "categories#arts_events"
  get "misc_events", to: "categories#misc_events"

end
