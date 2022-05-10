Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: %i(index create)

      namespace :users do
        resources :sessions, only: %i(create)
        resources :balance_transactions, only: %i(index create)
      end
    end
  end
end
