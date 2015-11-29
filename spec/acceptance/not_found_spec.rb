require 'spec_helper'

describe 'Not Found' do
  it 'is returned when route does not exist' do
    get '/not_found'

    expect(last_response.status).to eq(404)
  end
end
