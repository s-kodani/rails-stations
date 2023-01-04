Rails.application.routes.draw do
  root "movies#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :movies, only: [:index, :show] do
    resources :schedules do
      resources :reservations, only: [:new]
    end
    get 'reservation', to: 'sheets#index'
  end
  resources :reservations, only: [:create]
  resources :sheets, only: [:index]
  namespace :admin do
    resources :movies do
      resources :schedules, except: [:index]
    end
    resources :schedules, only: [:index]
  end
end
