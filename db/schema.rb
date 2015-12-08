Sequel.migration do
  change do
    create_table(:credentials) do
      primary_key :id
      String :name, :size=>255, :null=>false
      String :username, :size=>255, :null=>false
      String :password, :size=>255, :null=>false
    end

    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end

    create_table(:users) do
      primary_key :id
      String :email, :size=>255, :null=>false
      String :public_key, :size=>255, :null=>false
      String :password_hash, :size=>255, :null=>false
      String :encrypted_private_key, :size=>255, :null=>false
    end

    create_table(:authorization_audits) do
      primary_key :id
      String :action, :size=>255, :null=>false
      foreign_key :executed_by_user_id, :users
      foreign_key :executed_for_user_id, :users
      foreign_key :credential_id, :credentials
      DateTime :date, :null=>false
    end

    create_table(:authorizations, :ignore_index_errors=>true) do
      primary_key :id
      foreign_key :user_id, :users
      foreign_key :credential_id, :credentials

      index [:user_id, :credential_id], :unique=>true
    end
  end
end
