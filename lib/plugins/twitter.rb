require_relative './twitter/authentication'
require_relative './twitter/account'

module Plugins
  module Twitter
    class UnavailableError < StandardError; end

    class << self
      def change_password(username, current_password, new_password)
        Account.change_password(username, current_password, new_password)
      end
    end
  end
end
