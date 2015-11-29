class Account::AuthorizationsController < ApplicationController
  def show
    user_id = User.last.id
    @authorizations = Authorization.where(user_id: user_id)
    @authorization_audits = AuthorizationAudit.where(executed_for_user_id: user_id)
  end
end
