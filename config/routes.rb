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

  namespace :sessions do
    patch '/meals/:dish_id',           to: 'meals#update'
    delete '/meals/:dish_id',          to: 'dishes#destroy'
  end

  get '/gut_feelings',                to: 'meals#index', as: 'gut_feelings'

  namespace :sessions do
    patch '/dishes/:food_id',         to: 'dishes#update'
    delete '/dishes/:food_id',         to: 'foods#destroy'
  end

  resources :meals,                 only: [:new, :create, :edit, :update, :destroy]
  resources :dishes,                only: [:new, :create, :edit, :destroy]
  resources :foods,                 only: [:new, :create, :destroy]

  namespace :foods do
    post :barcode
  end
end
