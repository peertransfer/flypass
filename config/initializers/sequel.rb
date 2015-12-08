require 'sequel'

DB = Sequel.sqlite("./db/#{ENV['RACK_ENV']}.db")
