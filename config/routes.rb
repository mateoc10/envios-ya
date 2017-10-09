Rails.application.routes.draw do
  
  root 'layout#home'
  get 'users/new'
  get  '/signup',  to: 'users#new'
  get 'layout/home'
  resources :users
  post '/signup',  to: 'users#create'
  
end
