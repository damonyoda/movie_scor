Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies, only: [:index, :show] do
        collection do 
          get :search
        end
        resources :reviews, only: [:index, :show]
      end
      resources :actors, only: [:index, :show] do 
        collection do 
          get :search
        end
      end
    end
  end
end
