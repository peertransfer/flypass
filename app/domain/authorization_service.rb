class AuthorizationService
  def self.update(user_id, credential_ids)
    current = Authorization.where(user_id: user_id).map(&:credential_id)

    to_revoke = current - credential_ids
    to_grant = credential_ids - current

    revoke(user_id, to_revoke)
    grant(user_id, to_grant)
  end

  def self.grant(user_id, credential_ids)
    credential_ids.each do |credential_id|
      Authorization.create(user_id: user_id, credential_id: credential_id)
    end
  end

  def self.revoke(user_id, credential_ids)
    credential_ids.each do |credential_id|
      authorization = Authorization.find_by(credential_id: credential_id, user_id: user_id)
      authorization.destroy

      credential = Credential.find(credential_id)

      plugin_class = "Plugins::#{credential.name.capitalize}".constantize

      new_password = SecureRandom.urlsafe_base64

      plugin_class.change_password(credential.username, credential.password, new_password)
      credential.update_attributes(password: new_password)
    end
  end
end
