Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :posts do
    resources :comments
  end   
  post 'posts/add_like/:id', to: 'posts#add_like', as: 'post_add_like'
  post 'users/request_friend/:id', to: 'users#request_friend', as: 'request_friend'
  post 'users/accept_friend/:id', to: 'users#accept_friend', as: 'accept_friend'
  post 'friendships/destroy/:id', to: 'friendships#destroy', as: 'destroy_friendship'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
