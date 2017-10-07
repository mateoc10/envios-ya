Rails.application.routes.draw do
  
  get 'users/new'

  get  '/signup',  to: 'users#new'
  get 'layout/home'
  root 'layout#home'
  
end
