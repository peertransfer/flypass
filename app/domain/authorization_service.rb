class AuthorizationService
  def self.update(admin_id, user_id, credential_ids)
    current = Authorization.where(user_id: user_id).map(&:credential_id)

    to_revoke = current - credential_ids
    to_grant = credential_ids - current

    revoke(user_id, to_revoke)
    grant(admin_id, user_id, to_grant)
  end

  def self.grant(admin_id, user_id, credential_ids)
    user = User.find(user_id)
    admin = User.find(admin_id)


    credential_ids.each do |credential_id|
      admin_authorization = Authorization.find_by(user_id: admin_id, credential_id: credential_id)
      admin_private_key = Rails.application.secrets.admin_private_key
      credential_key = admin.decrypt_with_private_key(admin_authorization.encrypted_credential_key, admin_private_key)

      encrypted_credential_key = user.encrypt_with_public_key(credential_key)

      Authorization.create(
        user_id: user_id,
        credential_id: credential_id,
        encrypted_credential_key: encrypted_credential_key
      )
    end
  end

  def self.revoke(user_id, credential_ids)
    credential_ids.each do |credential_id|
      authorization = Authorization.find_by(
        credential_id: credential_id,
        user_id: user_id
      )
      authorization.destroy

      credential = Credential.find(credential_id)

      plugin_class = "Plugins::#{credential.name.capitalize}".constantize

      new_password = SecureRandom.urlsafe_base64

      plugin_class.change_password(
        credential.username,
        credential.password, new_password
      )

      credential.update_attributes(password: new_password)
    end
  end
end
