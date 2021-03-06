Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
  end

  resources :leagues, except: [:new, :edit]
  resources :teams, except: [:new, :edit]
  resources :users, only: [:destroy, :index, :show, :create, :update]
  resources :results, except: [:new, :edit]
  resources :invitations, only: [:create, :new, :update, :destroy]
end

