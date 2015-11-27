require_relative 'authentication'
require_relative 'account'

module Plugins
  module Twitter
    class UnavailableError < StandardError; end
    class << self
      def login(username, password)
        Authentication.login(username, password)
      end

      def change_password(username, current_password, new_password)
        Account.change_password(username, current_password, new_password)
      end
    end
 end
end
