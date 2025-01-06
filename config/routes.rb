Rails.application.routes.draw do
  devise_for :users

  resources :chat_rooms, only: [:index] do
    resources :messages, only: [:create]
  end
  root to: "chat_rooms#index"
end
