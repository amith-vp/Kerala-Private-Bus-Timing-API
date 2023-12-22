# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :schedules, only: [:index]
      resources :search, only: [:index]
    end
  end
end
