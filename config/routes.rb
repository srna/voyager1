Rails.application.routes.draw do
  devise_for :users
  root to: 'root#index'
  resource :profile
end
