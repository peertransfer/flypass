require 'time'
require 'base64'
require 'cgi'
require 'openssl'

class AuditLog
  attr_reader :executed_by_user, :executed_for_user, :action, :authorization_name, :date

  def initialize(executed_by_user, executed_for_user, authorization, action)
    @executed_by_user = executed_by_user
    @executed_for_user = executed_for_user
    @action = action
    @authorization = authorization
    @date = Time.now.utc.iso8601
  end

  def checksum
    require 'byebug'
    debugger
    CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1', Rails.configuration.authorization_audit_secret, signature)}\n"))
  end

  private

  def signature
    "#{executed_by_user.id}#{executed_for_user}#{authorization.credential.id}#{action}#{date}"
  end
end
