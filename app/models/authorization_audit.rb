class AuthorizationAudit < ActiveRecord::Base
  belongs_to :credential
  before_save :set_checksum, :set_date
  attr_reader :checksum

  private

  def set_date
    self.date = Time.now.utc.iso8601
  end

  def set_checksum
    self.checksum = CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1', Rails.configuration.authorization_audit_secret, signature)}\n"))
  end

  def signature
    "#{executed_by_user_id}#{executed_for_user_id}#{credential_id}#{action}#{date}"
  end
end
