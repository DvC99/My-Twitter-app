Rails.application.routes.draw do
  devise_for :users, controllers:{
    confirmations: 'confirmations'
  }
  resources :tweets
  root'tweets#index'
  get 'home'=>'tweets#home'
  get 'profile/:username', to:'tweets#profile', as: 'profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
