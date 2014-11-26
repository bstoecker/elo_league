Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :leagues, except: [:new, :edit]

    resources :teams, except: [:new, :edit]

    resources :users, except: [:new, :edit]
  end
end
