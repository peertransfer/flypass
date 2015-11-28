require 'spec_helper'

describe AuthorizationService do
  it 'grants a credential for a user' do
    AuthorizationService.update(1, [1])

    authorization = Authorization.where(user_id: 1, credential_id: 1)
    expect(authorization).to be_present
  end

  it 'revokes a credential for a user' do
    allow(Plugins::Twitter).to receive(:change_password).and_return(true)
    user = User.create(email: 'wadus@wadus.com', password: '123456')
    Authorization.create(user_id: 1, credential_id: 1)

    AuthorizationService.update(1, [])
    authorization = Authorization.where(user_id: 1, credential_id: 1)


    expect(authorization).to be_empty
  end

  it 'changes the password of a credential' do
    credential = Credential.create(name: 'twitter', username: 'username', password: 'password')

    user = User.create(email: 'wadus@wadus.com', password: '123456')

    Authorization.create(user_id: user.id, credential_id: credential.id)

    secure_random = 'DXEFAMohL25NR7aWNaxUeg'

    allow(SecureRandom).to receive(:urlsafe_base64).
      and_return(secure_random)

    expect(Plugins::Twitter).to receive(:change_password).with(credential.username, credential.password, secure_random)

    AuthorizationService.update(user.id, [])
  end
end
