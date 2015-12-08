module User
  class Entity
    attr_accessor :email, :public_key, :password_hash, :encrypted_private_key

    def initialize(email:, public_key:, password_hash:, encrypted_private_key:)
      @email = email
      @public_key = public_key
      @password_hash = password_hash
      @encrypted_private_key = encrypted_private_key
    end
  end
end
