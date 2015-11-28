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
    # generate_keys(new_password)
    new_generate_keys(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def password_is?(candidate)
    password == candidate
  end

  def decrypt_private_key(passphrase)
    decipher = OpenSSL::Cipher.new('AES-256-CBC')
    decipher.iv = @iv

    decipher_key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(passphrase, @salt, @iter, @key_len)

    decipher.key = decipher_key
    decoded = Base64.decode64 self.encrypted_private_key.encode('ascii-8bit')
    plain = decipher.update(decoded) + decipher.final
    plain
  end

  def new_decrypt_private_key(passphrase)
    decoded = Base64.decode64 self.encrypted_private_key.encode('ascii-8bit')
    OpenSSL::PKey::RSA.new decoded, passphrase
  end

  def encrypt_with_public_key(data)
    pkey = OpenSSL::PKey::RSA.new(self.public_key)
    pkey.public_encrypt data
  end

  def decrypt_with_private_key(encrypted_data, passphrase)
    private_key = self.decrypt_private_key(passphrase)
    pkey = OpenSSL::PKey::RSA.new(private_key)
    pkey.private_decrypt(encrypted_data)
  end

  def new_decrypt_with_private_key(encrypted_data, passphrase)
    pkey = self.new_decrypt_private_key(passphrase)
    pkey.private_decrypt(encrypted_data)
  end

  private

  def generate_keys(passphrase)
    pkey = OpenSSL::PKey::RSA.new(4096)
    # Export public key
    public_key = pkey.public_key.to_pem

    # Create Cipher
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    @iv = cipher.random_iv

    # Create key for Cipher
    @salt = OpenSSL::Random.random_bytes(16)
    @iter = 20000
    @key_len = cipher.key_len
    cipher_key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(passphrase, @salt, @iter, @key_len)

    # Use the key created for Cipher
    cipher.key = cipher_key

    # Export public and private key
    self.public_key = pkey.public_key.to_s
    
    # Encrypt private key
    data = pkey.to_s
    encrypted_data = cipher.update(data) + cipher.final
    self.encrypted_private_key = Base64.encode64(encrypted_data).encode('utf-8')
  end

  def new_generate_keys(passphrase)
    cipher = OpenSSL::Cipher.new('AES-256-CBC')

    pkey = OpenSSL::PKey::RSA.new(4096)
    # Export public key
    self.public_key = pkey.public_key.to_pem
    secure_private_key = pkey.export cipher, passphrase

    self.encrypted_private_key = Base64.encode64(secure_private_key).encode('utf-8')
  end
end
