class AddPasswordToCredential < ActiveRecord::Migration
  def change
    add_column :credentials, :password, :string
  end
end
