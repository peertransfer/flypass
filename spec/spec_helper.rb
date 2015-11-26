# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

RSpec.configure do |config|
  syntax = :expect
  config.expect_with(:rspec) { |c| c.syntax = syntax }
  config.mock_with(:rspec) { |c| c.syntax = syntax }


  config.before(:suite) do
  end

  config.before(:each) do
  end

  config.after(:each) do
  end

  config.after(:each, type: :request) do
  end
end
