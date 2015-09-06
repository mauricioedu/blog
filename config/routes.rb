Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

resources :posts do
  member do
    put "like", to: "posts#upvote"
    put "dislike", to: "posts#downvote"
  end
  resources :comments
 mount Ckeditor::Engine => "/ckeditor" 
end


  
  root  "posts#index"
end
