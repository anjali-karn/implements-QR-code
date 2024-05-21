Rails.application.routes.draw do
  resources :posts do
    member do
      get :qr_code
    end
  end
  # Other routes...
end
