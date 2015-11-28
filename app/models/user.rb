require 'bcrypt'
require 'openssl'

class User < ActiveRecord::Base
  include BCrypt

  has_many :authorizations
  has_many :credentials, through: :authorizations

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    generate_keys(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def encrypt_with_public_key(data)
    pkey = OpenSSL::PKey::RSA.new(self.public_key)
    pkey.public_encrypt data
  end

  def decrypt_with_private_key(encrypted_data, passphrase)
    pkey = OpenSSL::PKey::RSA.new self.encrypted_private_key, passphrase
    pkey.private_decrypt(encrypted_data)
  end

  private

  def generate_keys(passphrase)
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    pkey = OpenSSL::PKey::RSA.new(4096)
    self.public_key = pkey.public_key.to_pem
    self.encrypted_private_key = pkey.export cipher, passphrase
  end
end
