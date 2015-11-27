class AddPasswordPublicAndEncryptedPrivateKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :password, :string
    add_column :users, :public_key, :string
    add_column :users, :encrypted_private_key, :string
  end
end
