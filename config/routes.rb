Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"

  # prototypesコントローラーには7つのアクションが含まれている
  # prototypesコントローラーの中にcommentsコントローラーを入れることで、コメントと結びつく投稿のidをparamsに追加
  resources :prototypes do
    resources :comments, only: [:create]
  end
  resources :users, only: :show
end