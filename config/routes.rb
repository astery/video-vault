Rails.application.routes.draw do
  resources :videos

  authenticated :user do
    root :to => 'videos#index', as: :authenticated_root
  end

  root to: 'visitors#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
