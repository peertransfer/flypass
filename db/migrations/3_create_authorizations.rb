Sequel.migration do
  up do
    create_table(:authorizations) do
      primary_key :id
      foreign_key :user_id, :users
      foreign_key :credential_id, :credentials

      index [:user_id, :credential_id], unique: true
    end
  end

  down do
    drop_table(:authorizations)
  end
end
