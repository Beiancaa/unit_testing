Rails.application.routes.draw do
  get 'home/index'
  resources :tests
  root 'home#index'
end
