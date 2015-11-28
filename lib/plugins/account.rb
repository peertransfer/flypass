require 'mechanize'
require_relative 'authentication'

module Plugins
  module Twitter
    module Account
      KNOWN_EXCEPTIONS = [SocketError, Errno::ECONNREFUSED, Errno::ETIMEDOUT]
      CHANGE_PASSWORD_URL = 'https://twitter.com/settings/password'
      CHANGE_PASSWORD_FORM_ACTION = 'https://twitter.com/settings/passwords/update'
      PASSWORD_CHANGED_SUCCESS_URL = 'https://twitter.com/settings/passwords/password_reset_confirmation'
      CURRENT_PASSWORD_FORM_FIELD = 'current_password'
      NEW_PASSWORD_FORM_FIELD = 'user_password'
      NEW_PASSWORD_CONFIRMATION_FORM_FIELD = 'user_password_confirmation'

      class ParsingError < StandardError; end

      def self.change_password(username, current_password, new_password)
        login_response = Authentication.login(username, current_password)
        return login_error(login_response) unless login_response.success?
        agent.cookie_jar = login_response.cookies
        agent.get(CHANGE_PASSWORD_URL) do |page|
          response = page.form_with(:action => CHANGE_PASSWORD_FORM_ACTION) do |form|
            parsing = parse_form(form)
            raise ParsingError.new(parsing.error) unless parsing.success?
            form[CURRENT_PASSWORD_FORM_FIELD] = current_password
            form[NEW_PASSWORD_FORM_FIELD] = new_password
            form[NEW_PASSWORD_CONFIRMATION_FORM_FIELD] = new_password
          end.submit
          return password_change_error unless password_changed?(response)
          return success
        end
        rescue *KNOWN_EXCEPTIONS => exception
          handle_known_exception(exception)
      end

      private

      def self.agent
        ag ||= Mechanize.new { |agent|
          agent.user_agent_alias = 'Mac Safari'
        }
      end

      def self.handle_known_exception(exception)
        error_message = "#{exception.class.name}: #{exception.message}"
        raise_unavailable(error_message)
      end

      def self.raise_unavailable(message)
        raise Twitter::UnavailableError.new(message)
      end

      def self.password_change_error
        error("Password change error")
      end

      def self.success
        OpenStruct.new(:success? => true)
      end

      def self.password_changed?(response)
        response.uri.to_s == PASSWORD_CHANGED_SUCCESS_URL
      end

      def self.login_error(login_response)
        OpenStruct.new(:success? => false, :error => login_response.error)
      end

      def self.parse_form(form)
        return error("Could not found login form") unless form
        return error("Could not found username field") unless form[CURRENT_PASSWORD_FORM_FIELD]
        return error("Could not found password field") unless form[NEW_PASSWORD_FORM_FIELD]
        return error("Could not found password field") unless form[NEW_PASSWORD_CONFIRMATION_FORM_FIELD]

        return OpenStruct.new(:success? => true)
      end

      def self.error(message)
        return OpenStruct.new(:success? => false, :error => message)
      end
    end
  end
end
