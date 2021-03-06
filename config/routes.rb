Rails.application.routes.draw do

  root 'homes#about'

  devise_for :users

  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    get 'likedby' => "likes#likedby"
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get :likes
    end
    resource :relationships, only: [:create, :destroy]
    get 'following' => 'relationships#following', as: 'following'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get '/post/hashtag/:name' => "posts#hashtag"

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
