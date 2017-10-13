Rails.application.routes.draw do
  
  get 'driver_sessions/new'
  get 'drivers/new'
  get 'sessions/new'

  root 'layout#home'
  get 'users/new'
  get  '/signup',  to: 'users#new'
  get 'layout/home'
  
  resources :users
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :drivers
  get '/drivers/signup', to: 'drivers#new'
  post '/drivers/signup', to: 'drivers#create'
  
  get    '/drivers_session/login',   to: 'driver_sessions#new'
  post   '/drivers_session/login',   to: 'driver_sessions#create' 
  
  
end
