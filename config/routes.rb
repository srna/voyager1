Rails.application.routes.draw do
  devise_for :users
  root to: 'root#index'
  resource :profile
  resources :invoices, except: [:edit, :update, :create] do
    get '/import/:id' => 'invoices#import', as: :import, on: :collection
    resources :lines, only: [:edit, :update]
  end
end
