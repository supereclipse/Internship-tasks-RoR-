Rails.application.routes.draw do
  # Routes для практик
  namespace :admin do
    root 'welcome#index'
  end
  root 'orders#calc'

  resource :login, only: %i[show create destroy]

  resources :users

  resources :orders do
    member do
      get 'approve'
      get 'calc'
    end

    get 'first', on: :collection
  end

  get 'hello/index'

  # HW 6
  get 'check', to: 'orders#check'

  # Praktiki po grape api
  resources :vms

  mount GrapeApi => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'

  resources :groups

  # Praktika po async
  mount Sidekiq::Web => '/sidekiq'

  # HW 8
  resources :reports
end
