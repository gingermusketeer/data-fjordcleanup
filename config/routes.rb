Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "root#index"
  get "/map", to: "root#map", as: "map"
  get "/login", to: "root#login"
  resources :locations do
    member do
      get :popup
    end
  end
  resources :cleanups, only: [:create, :new, :index, :edit, :update]
end
