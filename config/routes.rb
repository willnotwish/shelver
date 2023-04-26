Rails.application.routes.draw do
  get 'home/index'
  resources :units
  resources :sheets
  resources :composites

  root 'home#index'
end
