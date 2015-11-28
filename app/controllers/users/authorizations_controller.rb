module Users
  class AuthorizationsController < ApplicationController
    def show
      user = User.find(params[:user_id])
      @credential_ids = user.credentials.pluck(:id)
    end

    def update
      credential_ids = params[:authorizations][:credentials].reject(&:empty?).map(&:to_i)

      user_id = params[:user_id]
      admin_id = current_user

      AuthorizationService.update(admin_id, user_id, credential_ids)
    end
  end
end
