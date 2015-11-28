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

    expect(Credential.find(credential.id).password).to eq(secure_random)
  end

  it 'creates a crendential' do
    credential = Credential.where('wadus')
    authorization = Authorization.where('wadus')

    expect(credential).to_not be_present
    expect(authorization).to_not be_present

    AuthorizationService.create_credential('wadus')

    credential = Credential.where('wadus')
    authorization = Authorization.where('wadus', encrypted_credential_key: 'ojete')

    expect(credential).to be_present
    expect(authorization).to be_present
  end

  it 'creates a credential' do
    admin = User.create(email: 'wadus@wadus.com', password: '123456')
    AuthorizationService.create_credential('wadus')

    




  # it 'changes the password of a crendential using a secure approach' do
  #   cipher = OpenSSL::Cipher.new('AES-256-CBC')
  #   cipher.encrypt
  #   key = cipher.random_key
  #   iv = cipher.random_iv
  #   encrypted_password = cipher.update(data) + cipher.final
  # end
end
