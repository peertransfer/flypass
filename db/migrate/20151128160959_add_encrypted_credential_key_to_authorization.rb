class AddEncryptedCredentialKeyToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :encrypted_credential_key, :string
  end
end
