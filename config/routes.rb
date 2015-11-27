Rails.application.routes.draw do
  resources :users do
    resource :authorizations, controller: 'users/authorizations'
  end
end
