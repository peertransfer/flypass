class Account::AuthorizationsController < ApplicationController
  def show
    @authorizations = Authorization.where(user_id: User.last.id)
  end
end
