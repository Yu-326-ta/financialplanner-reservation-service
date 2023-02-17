Rails.application.routes.draw do
  root 'static_pages#home'
  get '/planners/signup', to: 'planners#new'
  get '/clients/signup', to: 'clients#new'
  get  '/help', to: 'static_pages#help'
  resources :clients
end
