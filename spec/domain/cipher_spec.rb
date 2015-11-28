require 'spec_helper'


describe Cipher do
  pending 'generates an encrypted credential key' do
    admin = User.create(email: 'foo@bar.com', password: 'the_pass')
    credential = Credential.create(name: 'Twitter', password: 'the_pass')
    authorization = Authorization.create(user_id: admin.id, credential_id: credential.id)
    credential_key = 'the_credential_key'
    admin_private_key = Rails.application.secrets.admin_private_key

    pkey = OpenSSL::PKey::RSA.new admin_private_key
    credential_key = pkey.private_decrypt(encrypted_credential_key)


    credential_key = Cipher.decrypt_credential_key(admin_private_key, encrypted_credential_key)
    Cipher.encrypt_credential_key(user.public_key, encrypt_credential_key)

    expect(Cipher.generate_encrypted_key())
  end

  it 'encrypts and decrypts a credential key' do
    pkey = OpenSSL::PKey::RSA.new(4096)
    public_key = pkey.public_key.to_pem
    private_key = pkey.to_pem

    decrypted_credential_key = 'decrypted'

    encrypted_credential_key = Cipher.encrypt_credential_key(public_key, decrypted_credential_key)

    expect(Cipher.decrypt_credential_key(
      private_key, 
      encrypted_credential_key)
    ).to eq(decrypted_credential_key)
  end

  it 'encrypts and decrypts a credential password' do
    key = Cipher.random_key
    iv = Cipher.random_iv
    cipher = Cipher.new(key, iv)
    
    plain = 'decrypted'
    
    encrypted = cipher.encrypt(plain)

    expect(cipher.decrypt(encrypted)).to eq(plain)
  end

  pending 'decrypts password'
end