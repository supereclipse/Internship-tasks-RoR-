Rails.application.routes.draw do
  resources :users
  #resources :orders

  resources :orders do
    member do
      get 'approve'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'hello/index'
end


