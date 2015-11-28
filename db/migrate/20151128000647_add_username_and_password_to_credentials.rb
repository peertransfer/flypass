class AddUsernameAndPasswordToCredentials < ActiveRecord::Migration
  def change
    add_column :credentials, :username, :string
    add_column :credentials, :password, :string
  end
end
