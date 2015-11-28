require 'spec_helper'


describe KeyPair do
  it 'encrypts and decrypts a credential key' do
    keys = KeyPair.generate
    public_key = keys[:public_key]
    private_key = keys[:private_key]
    
    key_pair = KeyPair.new(private_key)

    plain = 'decrypted'

    encrypted = key_pair.public_encrypt(plain)

    expect(key_pair.private_decrypt(encrypted)).to eq(plain)
  end
end