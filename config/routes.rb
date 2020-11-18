Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :login, to: 'auth#login'
      post :translate, to: 'translate#index'
      post :iot, to: "iot#update"
      get :iot_find_building, to: "iot#find"

      resources :users do
        collection do
          get :me
          put :locale
        end
      end

      resources :universities, only: [:index, :show] do
        resources :groups, only: [:create, :index, :show, :destroy]
        resources :buildings
        post :register_user
      end

      resources :universities_non_auth, only: [:create]

      resources :events do
        resources :comments
        resources :bookings
        collection do
          get :search
          get :nearest_events
        end
        member do
          post :attend
        end
      end
      
      resources :conversations do
        member do
          post :create_message
        end
        resources :conversations_participants, only: [:show, :create, :index]
        resources :chat_messages, only: [:show, :create, :index]
      end
    end
  end

  mount ActionCable.server => '/cable'
end
