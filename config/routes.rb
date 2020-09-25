Rails.application.routes.draw do

  devise_for :users
  root 'posts#index'
  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'following' => 'relationships#following', as: 'following'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  get '/post/hashtag/:name' => "posts#hashtag"

  get '/posts/likerank' => "posts#likerank"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
