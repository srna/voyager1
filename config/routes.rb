Rails.application.routes.draw do
  devise_for :users
  root to: 'root#index'
  resource :profile
  resources :invoices do
    get '/import/:id' => 'invoices#import', as: :import, on: :collection
  end
end
