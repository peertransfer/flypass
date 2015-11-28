class KeyPair
  KEY_SIZE = 4096

  def self.generate
    key_pair = OpenSSL::PKey::RSA.new(KEY_SIZE)
    {
      public_key: key_pair.public_key.to_pem,
      private_key: key_pair.to_pem
    }
  end

  def initialize(key)
    @key = key
  end

  def public_encrypt(plain)
    pkey = OpenSSL::PKey::RSA.new(@key)
    pkey.public_encrypt(plain)
  end

  def private_decrypt(encrypted)
    pkey = OpenSSL::PKey::RSA.new(@key)
    pkey.private_decrypt(encrypted)
  end

  def self.decrypt_credential_key(private_key, encrypted_credential_key)  
    pkey = OpenSSL::PKey::RSA.new(private_key)
    pkey.private_decrypt(encrypted_credential_key)
  end

  def self.encrypt_credential_key(public_key, decrypted_credential_key)
    pkey = OpenSSL::PKey::RSA.new(public_key)
    pkey.public_encrypt(decrypted_credential_key)
  end
end