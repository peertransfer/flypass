require 'spec_helper'

describe AuthorizationService do
  it 'grants a credential for a user' do
    AuthorizationService.update_for_user(1, [1])

    authorization = Authorization.where(user_id: 1, credential_id: 1)
    expect(authorization).to be_present
  end

  it 'revokes a credential for a user' do
    Authorization.create(user_id: 1, credential_id: 1)

    AuthorizationService.update_for_user(1, [])
    authorization = Authorization.where(user_id: 1, credential_id: 1)

    expect(authorization).to be_empty
  end
end
