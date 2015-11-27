Rails.application.routes.draw do
  resources :users do
    resource :authorizations, to: 'users/authorizations'
  end
end
