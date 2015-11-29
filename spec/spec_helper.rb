ENV['RACK_ENV'] = 'test'
require_relative '../config/boot'

require 'rack/test'

RSpec.configure do |config|
  syntax = :expect
  config.expect_with(:rspec) { |c| c.syntax = syntax }
  config.mock_with(:rspec) { |c| c.syntax = syntax }

  include Rack::Test::Methods

  def app
    MyApplication::Dispatcher.new
  end
end
