# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'schedules/:departure/:destination', to: 'schedules#index'
      resources :search, only: [:index]
    end
  end
end
