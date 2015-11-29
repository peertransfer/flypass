class CreateAuthorizationAudits < ActiveRecord::Migration
  def change
    create_table :authorization_audits do |t|
      t.string :action
      t.integer :executed_by_user_id
      t.integer :executed_for_user_id
      t.integer :credential_id
      t.datetime :date
      t.string :checksum
    end
  end
end
