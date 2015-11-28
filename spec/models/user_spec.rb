require 'spec_helper'

describe User do
  let (:password) { 'password' }
  let (:user) { User.create(email: 'foo@bar.com', password: password) }

  it 'knows his password' do
    expect(user.password_is?(password)).to eq(true)
    expect(user.password_is?('wrong')).to eq(false)
  end

  it 'has a generated pair key' do
    expect(user.public_key?).to eq(true)
    expect(user.encrypted_private_key?).to eq(true)
  end

  it 'decrypt data encrypted with his public key' do
    data = 'Secret data'

    encrypted_data = user.encrypt_with_public_key(data)

    decrypted_data = user.new_decrypt_with_private_key(encrypted_data, password)

    expect(decrypted_data).to eq(data)
  end
end
