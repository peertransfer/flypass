module Users
  class AuthorizationsController < ApplicationController
    def show
      user = User.first
      @credential_ids = user.credentials.pluck(:id)
    end

    def update
      credential_ids = params[:authorizations][:credentials].reject(&:empty?).map(&:to_i)

      user_id = params[:user_id]
      AuthorizationService.update(user_id, credential_ids)
    end
  end
end
