Rails.application.routes.draw do
  get '/clients/signup', to: 'clients#new'
  root "static_pages#home"
  get  "/help", to: "static_pages#help"
end
