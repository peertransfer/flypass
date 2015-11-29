require 'spec_helper'

describe 'API Endpoint' do
  it 'responds with a JSON welcoming message' do
    get '/api'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('{"message":"Hello Developer"}')
  end

  def app
    MyApplication::Dispatcher.new
  end
end
