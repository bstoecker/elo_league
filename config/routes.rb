Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :leagues, except: [:new, :edit]
  resources :teams, except: [:new, :edit]
  resources :users, except: [:new, :edit]
  resources :results, except: [:new, :edit]
end
