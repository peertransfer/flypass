Sequel.migration do
  up do
    create_table(:authorization_audits) do
      primary_key :id
      String :action, null: false
      foreign_key :executed_by_user_id, :users
      foreign_key :executed_for_user_id, :users
      foreign_key :credential_id, :credentials
      DateTime :date, null: false
    end
  end

  down do
    drop_table(:authorization_audits)
  end
end
