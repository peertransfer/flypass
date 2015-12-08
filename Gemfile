source 'https://rubygems.org'

gem 'sinatra', '~> 1.4.6'

gem 'airbrake', '~> 4.1.0'
gem 'foreman', '~> 0.62.0', require: false
gem 'sqlite3', '~> 1.3.11'
gem 'sequel', '~> 4.29.0'
gem 'rake', '~> 10.4.2'

group :development do
  gem 'thin', '~> 1.6.3'
end

group :test do
  gem 'rspec', '~> 3.1.0'
  gem 'rack-test', '~> 0.6.2'
  gem 'byebug'
  gem 'database_cleaner', '~> 1.5.1'
end

group :production do
  gem 'unicorn', '~> 4.8.2'
  gem 'newrelic_rpm', '~> 3.7.3.204'
end
