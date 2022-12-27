Rails.application.routes.draw do
  root "movies#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :movies, only: [:index, :show]
  resources :sheets, only: [:index]
  namespace :admin do
    resources :movies do
      resources :schedules
    end
    resources :schedules, only: [:index]
  end
end
