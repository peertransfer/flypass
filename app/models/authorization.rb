class Authorization < ActiveRecord::Base
  belongs_to :user
  belongs_to :credential
  before_save { |instance| AuthorizationAuditService.log_grant(instance) }
  after_destroy { |instance| AuthorizationAuditService.log_revoke(instance) }
end
