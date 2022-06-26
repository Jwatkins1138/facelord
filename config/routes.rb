Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  resources :users
  resources :posts do
    resources :comments
  end   

  get '/users/:user_id/friends', to: 'users#friends_index', as: 'user_friends'
  post 'posts/add_like/:id', to: 'posts#add_like', as: 'post_add_like'
  post 'users/request_friend/:id', to: 'users#request_friend', as: 'request_friend'
  post 'users/accept_friend/:id', to: 'users#accept_friend', as: 'accept_friend'
  post 'friendships/destroy/:id', to: 'friendships#destroy', as: 'destroy_friendship'
  post 'posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
