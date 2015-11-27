module Users
  class AuthorizationsController < ApplicationController
    def create
      debugger
      credentials = params[:authorizations][:credentials].reject(&:empty?)
      credentials.each do |credential_id|
        next if Authorization.where(user_id: params[:user_id], credential_id: credential_id).present?

        Authorization.create(user_id: params[:user_id], credential_id: credential_id)
      end
    end
  end
end
