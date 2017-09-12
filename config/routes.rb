Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :messages do
    member do
      get "like" => "messages#upvote"
      get "dislike" => "messages#downvote"
      end
    collection do
      get :recent
      get :oldest
      get :upvoted
      get :downvoted
    end
  	resources :comments
  end
  root 'messages#index'
end
