Rails.application.routes.draw do
  root 'welcome#index'

  get '/register',  to: 'users#new'
  get '/help',      to: 'help#index'
  get '/dashboard', to: 'users#show'

  get '/auth/google_oauth2', as: 'google_connect'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
end
