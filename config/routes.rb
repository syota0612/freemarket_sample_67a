Rails.application.routes.draw do
  devise_for :users
  
  root "items#index"
  resources :items do
    resources :comments, only: :create
    collection do
      get :edit
    end
    member do
      get :purchase
    end
  end
  
  resources :addresses
  resources :users, only: [:index, :show, :new, :edit, :update] do
    
    collection do
      get :login
      get :logout
      get :card
      get :add
    end
  end

  resources :credit, only: [:index, :new, :show] do
    collection do
      post 'show', to: 'credit#show'
      post 'pay', to: 'credit#pay'
      post 'delete', to: 'credit#delete'
      # post 'purchase', to: 'credit#purchase'
    end
    member do
      post 'purchase', to: 'credit#purchase'
    end
  end

end
