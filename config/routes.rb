Rails.application.routes.draw do

  devise_for :users
  root 'posts#index'
  resources :posts do
    resource :likes, only: [:create, :destroy]
  end
  resources :users,param: :name, path: '/', only: [:show, :edit, :update]
  get '/post/hashtag/:name' => "posts#hashtag"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
