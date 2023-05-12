Rails.application.routes.draw do
  get 'home/index'
  resources :sheets
  resources :units do
    resources :panels, only: :index
  end
  resources :composites do
    resources :panels, only: :index
    resource :scaling_factor, only: %i[edit update]
    get 'edit-scaling-factor'
    put 'update-scaling-factor'
  end
  resources :projects do
    resources :panels, only: :index
  end
  resources :panels, only: :index

  root 'home#index'
end
