Rails.application.routes.draw do
  root 'static_pages#home'
  get '/planners/signup', to: 'planners#new'
  get '/clients/signup', to: 'clients#new'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get    'clients/login',   to: 'clients_sessions#new'
  post   'clients/login',   to: 'clients_sessions#create'
  delete 'clients/logout',  to: 'clients_sessions#destroy'
  get    'planners/login',   to: 'planners_sessions#new'
  post   'planners/login',   to: 'planners_sessions#create'
  delete 'planners/logout',  to: 'planners_sessions#destroy'
  resources :clients
  resources :planners
  resources :reservations
end
