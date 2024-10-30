Rails.application.routes.draw do
  devise_for :users

  scope path: '/', module: 'api/v1', as: 'events' do
    resources :events do
      member do
        post :join
        post :unjoin
      end
    end
  end

  root "home#index"
end
