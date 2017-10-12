Rails.application.routes.draw do
  
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
  
  
end
