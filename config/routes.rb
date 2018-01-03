Rails.application.routes.draw do
  resources :users
  resources :venues
  resources :events
  resources :attractions

  root to: "welcome#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
