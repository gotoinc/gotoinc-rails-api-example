Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :register, to: 'auth#register'
      post :login, to: 'auth#login'

      resources :users do
        collection do
          get :me, to: 'users#me'
        end
      end
    end
  end
end
