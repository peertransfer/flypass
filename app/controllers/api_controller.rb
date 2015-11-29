require 'json'

class ApiController < ApplicationController
  get '/api' do
    JSON.dump('message' => 'Hello Developer')
  end
end
