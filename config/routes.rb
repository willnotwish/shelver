Rails.application.routes.draw do
  get 'home/index'
  resources :units
  resources :sheets
  resources :composites do
    resources :panels, only: :index
  end

  root 'home#index'
end
