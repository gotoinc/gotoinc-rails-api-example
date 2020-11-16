Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :login, to: 'auth#login'
      post :translate, to: 'translate#index'

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
        resources :bookings
        collection do
          get :search
        end
        post :attend
      end
      
      resources :conversations do
        resources :conversations_participants, only: [:show, :create, :index]
        resources :chat_messages, only: [:show, :create, :index]
      end
    end
  end

  mount ActionCable.server => '/cable'
end
