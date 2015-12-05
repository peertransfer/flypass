Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :name, null: false
      String :public_key, null: false
      String :password_hash, null: false
      String :encrypted_private_key, null: false
    end
  end

  down do
    drop_table(:users)
  end
end
