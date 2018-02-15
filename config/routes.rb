Rails.application.routes.draw do
  
  get 'home/index'
  resources :test_activities
  root 'home#index'
end
