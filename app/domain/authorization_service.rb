class AuthorizationService
  def self.update_for_user(user_id, credential_ids)
    current = Authorization.where(user_id: user_id).map(&:credential_id)

    to_revoke = current - credential_ids
    to_grant = credential_ids - current

    to_revoke.each do |credential_id|
      authorization = Authorization.find_by(credential_id: credential_id, user_id: user_id)
      authorization.destroy
    end

    to_grant.each do |credential_id|
      Authorization.create(user_id: user_id, credential_id: credential_id)
    end
  end
end
