Rails.application.routes.draw do
  namespace :admin do
    root 'welcome#index'
  end

  resource :login, only: %i[show create destroy]

  root 'orders#calc'

  resources :users
  # resources :orders

  resources :orders do
    member do
      get 'approve'
      get 'calc'
    end
    get 'first', on: :collection
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'hello/index'
end
