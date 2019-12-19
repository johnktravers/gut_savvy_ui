Rails.application.routes.draw do
  root 'welcome#index'

  get '/register',                    to: 'users#new'
  get '/dashboard',                   to: 'users#show'
  
  get '/results',                     to: 'results#index'

  get '/auth/google_oauth2',          as: 'google_connect'
  get '/auth/google_oauth2/callback', to: 'sessions#create'

  resources :meals,                 only: [:new]
end
