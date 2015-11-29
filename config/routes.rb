Rails.application.routes.draw do
  resources :users do
    resource :authorizations, controller: 'users/authorizations'
    resource :audits, controller: 'users/audits'
  end

  namespace :account, format: false do
    resource :authorizations, controller: 'authorizations'
  end
end
