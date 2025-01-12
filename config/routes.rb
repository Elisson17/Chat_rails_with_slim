# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :chat_rooms, only: [:index] do
    resources :messages, only: [:create]
  end

  resources :invites, only: %i[create index destroy] do
    member do
      put 'accept'
      put 'decline'
    end
  end

  root 'chat_rooms#index'
end
