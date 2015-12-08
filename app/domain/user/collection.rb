module User
  class Collection
    class Data < Sequel::Model(:users); end

    class << self
      def persist(user)
        data_object = User::Collection::Data.new(
          email: user.email,
          public_key: user.public_key,
          password_hash: user.password_hash,
          encrypted_private_key: user.encrypted_private_key
        )

        data_object.save
      end

      def find_by_email(email)
        User::Collection::Data.where(email: email).first
      end
    end
  end
end
