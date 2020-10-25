# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
      resources :admin_users
      resources :memories
      resources :users

      root to: "admin_users#index"
    end
  devise_for :admin_users
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root to: "authentication#sign_up"

  post '/auth/login' => 'authentication#login'
  get '/auth/sign_up' => 'authentication#sign_up'
  get '/auth/check' => 'authentication#check'
  get '/auth/:provider/callback' => 'sessions#omniauth'

  get '/test' => 'test#index'
  resources :memories
end
