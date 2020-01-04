Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/help',                        to: 'help#show'
  get '/sign_in',                     to: 'users#new'
  get '/dashboard',                   to: 'users#show'

  get '/results',                     to: 'results#index'

  get '/auth/google_oauth2',          as: 'google_connect'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  delete '/logout',                   to: 'sessions#destroy'

  get '/gut_feelings',                to: 'meals#index', as: 'gut_feelings'

  resources :meals,                 only: [:new, :create]
  resources :dishes,                only: [:new, :create, :edit, :destroy]
  resources :foods,                 only: [:new, :create, :destroy]

  namespace :foods do
    post :barcode
  end
end
