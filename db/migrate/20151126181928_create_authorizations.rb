class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id
      t.integer :credential_id

      t.timestamps null: false
    end
  end
end
