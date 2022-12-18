Rails.application.routes.draw do
  post "auth/login", to: 'authentication#authenticate'
  
  resources :todos do
    resources :items
  end
end
