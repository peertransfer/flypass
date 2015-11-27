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
    end
  end
end
