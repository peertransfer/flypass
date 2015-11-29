class Users::AuditsController < ApplicationController
  def show
    @authorization_audits = AuthorizationAudit.where(executed_for_user_id: User.last.id)
  end
end
