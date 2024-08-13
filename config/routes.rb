Rails.application.routes.draw do
  # Routes for applications
  resources :applications, param: :token, only: [:index, :show, :create, :update, :destroy]

  
  resources :applications, param: :token, only: [] do
    resources :chats, only: [:index, :create, :show, :update, :destroy] do
      # Nested routes for messages under chats
      resources :messages, only: [:create, :index, :show, :update, :destroy] do
        collection do
          get 'search'
        end
      end
    end
  end

  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
