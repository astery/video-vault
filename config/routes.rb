Rails.application.routes.draw do
  resources :videos

  root to: 'videos#index', as: :authenticated_root
  root to: 'visitors#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
