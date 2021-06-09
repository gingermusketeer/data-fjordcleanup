Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "root#index"
  resources :locations do
    member do
      get :popup
    end
  end
end
