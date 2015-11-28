module Users
  class AuthorizationsController < ApplicationController
    def show
      user = User.find(params[:user_id])
      @credential_ids = user.credentials.pluck(:id)
    end

    def update
      credential_ids = params[:authorizations][:credentials].reject(&:empty?).map(&:to_i)

      user_id = params[:user_id]
      AuthorizationService.update(user_id, credential_ids)

      flash[:notice] = 'Credentials updated successfully'
      redirect_to user_authorizations_path(user_id: user_id)
    end
  end
end
