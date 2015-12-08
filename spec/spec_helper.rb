ENV['RACK_ENV'] = 'test'
require_relative '../config/boot'

require 'rack/test'
require 'database_cleaner'

RSpec.configure do |config|
  syntax = :expect
  config.expect_with(:rspec) { |c| c.syntax = syntax }
  config.mock_with(:rspec) { |c| c.syntax = syntax }

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  include Rack::Test::Methods

  def app
    MyApplication::Dispatcher.new
  end
end
