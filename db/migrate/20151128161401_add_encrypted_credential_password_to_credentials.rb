class AddEncryptedCredentialPasswordToCredentials < ActiveRecord::Migration
  def change
    add_column :credentials, :encrypted_password, :string
  end
end
