Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :register, to: 'auth#register'
      post :login, to: 'auth#login'
      post :translate, to: 'translate#index'

      resources :users do
        collection do
          get :me, to: 'users#me'
        end
      end

      resources :groups, only: [:create, :index, :show, :destroy]
      resources :universities, only: [:index, :show] do
        resources :buildings
      end

      resources :events do
        resources :bookings
      end
      
      resources :conversations do
        resources :conversations_participants, only: [:show, :create, :index]
        resources :chat_messages, only: [:show, :create, :index]
      end
    end
  end

  mount ActionCable.server => '/cable'
end
