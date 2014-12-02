Rails.application.routes.draw do
  devise_for :users
  root 'application#index'

  namespace :api, defaults: { format: :json } do
    get '/users', to: 'users#index_all'
    get '/users/:id', to: 'users#show'
    resources :leagues, except: [:new, :edit]
    resources :teams, except: [:new, :edit]
    resources :users, except: [:new, :edit]
    resources :results, except: [:new, :edit]
  end
end
