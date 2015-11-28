# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'rails/application'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'database_cleaner'

RSpec.configure do |config|
  syntax = :expect
  config.expect_with(:rspec) { |c| c.syntax = syntax }
  config.mock_with(:rspec) { |c| c.syntax = syntax }


  config.before(:suite) do
  end

  config.before(:each) do
    example = RSpec.current_example

    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner.start
    DatabaseCleaner.clean
  end

  config.after(:each) do
  end

  config.after(:each, type: :request) do
  end
end
