class AuthorizationAuditService
  ADMIN_USER_ID = 1

  def self.log_grant(authorization)
    authorization_audit = AuthorizationAudit.new(action: 'grant', executed_by_user_id: ADMIN_USER_ID, executed_for_user_id: authorization.user_id, credential_id: authorization.credential_id)
    authorization_audit.save
  end

  def self.log_revoke(authorization)
    authorization_audit = AuthorizationAudit.new(action: 'revoke', executed_by_user_id: ADMIN_USER_ID, executed_for_user_id: authorization.user_id, credential_id: authorization.credential_id)
    authorization_audit.save
  end
end
