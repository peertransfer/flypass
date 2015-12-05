Sequel.migration do
  up do
    create_table(:credentials) do
      primary_key :id
      String :name, null: false
      String :username, null: false
      String :password, null: false
    end
  end

  down do
    drop_table(:credentials)
  end
end
