Rails.application.routes.draw do
  
  get  '/signup',  to: 'users#new'
  get 'layout/home'
  root 'layout#home'
  
end
