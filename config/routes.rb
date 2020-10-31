Rails.application.routes.draw do
  resources :follows
  devise_for :users, controllers:{
    confirmations: 'confirmations'
  }
  resources :tweets
  root'tweets#index'
  get 'home'=>'tweets#home'
  get 'profile/:username', to:'tweets#profile', as: 'profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/user/:id/follow', to: "tweets#follow", as: "follow_user"
  post '/user/:id/unfollow', to: "tweets#unfollow", as: "unfollow_user"
  get 'followers/:username', to:'tweets#Followers', as: 'followers'
  get 'following/:username', to:'tweets#Following', as: 'following'
end
