Rails.application.routes.draw do
  
  get 'shipments/new'
  get 'admins/confirm'
  get 'driver_sessions/new'
  get 'drivers/new'
  get 'sessions/new'
  get 'admins/new'
  get 'admins/confirm_driver'
  post 'admins/confirm_driver'
  get 'drivers/shipment_list'
  get 'drivers/shipment'
  post 'drivers/shipment'
  get 'shipments/details'
  get 'admins/login'
  get 'drivers/get_drivers_json'

  root 'layout#home'
  get 'users/new'
  get  '/signup',  to: 'users#new'
  get 'layout/home'
  
  resources :users
  post '/signup',  to: 'users#create'
  # get '/get_user_by_id' to: 'users#get_user_by_id'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :drivers
  get '/drivers/signup', to: 'drivers#new'
  post '/drivers/signup', to: 'drivers#create'
  get 'drivers/shipment',  to: 'drivers#shipment'
  post 'drivers/shipment',  to: 'drivers#end_shipment'
  get '/drivers_session/login',   to: 'driver_sessions#new'
  post '/drivers_session/login',   to: 'driver_sessions#create' 
  post 'drivers/delivered', to: 'drivers#end_shipment'
  get 'drivers/get_drivers_json', to: 'drivers#get_drivers_json', format: :json
  
  
  resources :shipments
  get '/shipments/create', to: 'shipments#new'
  post '/shipments/create', to: 'shipments#create'
  post '/shipments/sendLocations', to: 'shipments#receive_locations'
  post '/shipment/details', to: 'shipments#details'
  
  resources :admin
  post '/admins/login', to: 'admins#login'
  post 'approve', to: 'admins#approve'
  post 'reject', to: 'admins#reject'
  # get '/admins/create', to: 'admins#create'
  post '/admins/approve', to: 'admins#approve'
  post '/admins/reject', to: 'admins#reject'
  
  #get '/admins/admins/create', to: 'admins#approve'
  #post '/reject', to: 'admins#reject'
  health_check_routes
  match '*path' => 'application#routing_error', :via => [:get]
  
  
end
