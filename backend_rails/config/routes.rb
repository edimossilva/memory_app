# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :admin do
    resources :admin_users
    resources :memories
    resources :users
    resources :tags

    root to: "admin_users#index"
  end

  scope 'auth' do
    post '/login' => 'authentication#login'
    get '/sign_up' => 'authentication#sign_up'
    get '/check' => 'authentication#check'
    get '/:provider/callback' => 'sessions#omniauth'
  end

  scope 'api/v1' do
    resources :memories
    resources :tags
    resources :memory_tags
  end

  get '/*path' => 'vue#index'

  root to: "vue#index"
end
