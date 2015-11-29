ENV['RACK_ENV'] ||= 'development'

# Bundler
require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require_relative '../lib/my_application.rb'

root_path = MyApplication.root
lib_path = File.join(MyApplication.root, 'lib')
app_path = File.join(MyApplication.root, 'app')
[root_path, lib_path, app_path].each { |path| $LOAD_PATH.unshift(path) }

ENV['PEERTRANSFER_ROOT'] = root_path

initializer_paths = Dir[MyApplication.root + '/config/initializers/*.rb']
initializer_paths.each { |file| require file }

require 'config/dispatcher'
