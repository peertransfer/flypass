class Cipher
  ALGORITHM = 'AES-256-CBC'

  def self.random_key
    cipher = OpenSSL::Cipher.new(ALGORITHM)
    cipher.random_key
  end

  def self.random_iv
    cipher = OpenSSL::Cipher.new(ALGORITHM)
    cipher.random_iv
  end

  def initialize(key, iv)
    @key = key
    @iv = iv
  end

  def encrypt(plain)
    cipher = OpenSSL::Cipher.new(ALGORITHM)
    cipher.encrypt
    cipher.key = @key
    cipher.iv = @iv
    cipher.update(plain) + cipher.final
  end

  def decrypt(encrypted)
    decipher = OpenSSL::Cipher.new(ALGORITHM)
    decipher.decrypt
    decipher.key = @key
    decipher.iv = @iv
    decipher.update(encrypted) + decipher.final
  end
end