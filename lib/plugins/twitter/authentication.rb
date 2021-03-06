require 'mechanize'

module Plugins
  module Twitter
    class Authentication
      KNOWN_EXCEPTIONS = [SocketError, Errno::ECONNREFUSED, Errno::ETIMEDOUT]
      LOGIN_URL = 'https://twitter.com'
      LOGIN_FORM_ACTION = 'https://twitter.com/sessions'
      USERNAME_LOGIN_FORM_FIELD = 'session[username_or_email]'
      PASSWORD_LOGIN_FORM_FIELD = 'session[password]'

      class ParsingError < StandardError; end

      def self.login(username, password)
        self.new(username, password).login
      end

      def initialize(username, password)
        @username = username
        @password = password
      end

      def login
        agent.get(LOGIN_URL) do |page|
          response = page.form_with(:action => LOGIN_FORM_ACTION) do |form|
            parsing = parse_form(form)

            raise ParsingError.new(parsing.messages) unless parsing.success?
            form[USERNAME_LOGIN_FORM_FIELD] = @username
            form[PASSWORD_LOGIN_FORM_FIELD] = @password
          end.submit

          return authentication_error unless authenticated?(response)
          return authentication_success
        end
        rescue *KNOWN_EXCEPTIONS => exception
          handle_known_exception(exception)
      end

      private

      def agent
        @ag ||= Mechanize.new { |agent|
          agent.user_agent_alias = 'Mac Safari'
        }
      end

      def handle_known_exception(exception)
        error_message = "#{exception.class.name}: #{exception.message}"
        raise_unavailable(error_message)
      end

      def raise_unavailable(message)
        raise Twitter::UnavailableError.new(message)
      end

      def authenticated?(response)
        response.form_with(:action => '/logout')
      end

      def authentication_error
        OpenStruct.new(:success? => false, :error => 'Authentication Error')
      end

      def authentication_success
        OpenStruct.new(:success? => true, :cookies => agent.cookie_jar)
      end

      def parse_form(form)
        return error("Could not found login form") unless form
        return error("Could not found username field") unless form[USERNAME_LOGIN_FORM_FIELD]
        return error("Could not found password field") unless form[PASSWORD_LOGIN_FORM_FIELD]
        return OpenStruct.new(:success? => true)
      end

      def error(message)
        return OpenStruct.new(:success? => false, :error => message)
      end
    end
  end
end
