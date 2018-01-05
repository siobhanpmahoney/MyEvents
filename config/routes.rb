Rails.application.routes.draw do
  resources :categories
  resources :users
  resources :venues
  resources :events
  resources :attractions

  root to: "welcome#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search', to: 'search#results'
  post 'search', to: 'search#results'

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "signup", to: "users#new"
  delete "logout", to: "sessions#destroy"

  get 'music_events', to: 'categories#all_music_events'
  get 'sports_events', to: 'categories#all_sports_events'
  get 'arts_events', to: 'categories#all_arts_events'
  get 'misc_events', to: 'categories#all_misc_events'


end
