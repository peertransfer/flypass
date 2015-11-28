class AddUsernameToCredential < ActiveRecord::Migration
  def change
    add_column :credentials, :username, :string
  end
end
