Rails.application.routes.draw do
  get 'layout/home'
  root 'layout#home'
end
