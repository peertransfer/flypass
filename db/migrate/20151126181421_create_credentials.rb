class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
