require 'spec_helper'

describe User::Collection do
  it 'persists users' do
    user_entity = User::Entity.new(
      email: 'test@test.com',
      public_key: 'key',
      password_hash: 'hash',
      encrypted_private_key: 'encrypted'
    )

    stored_user = User::Collection.find_by_email(user_entity.email)
    expect(stored_user).to be_nil

    User::Collection.persist(user_entity)
    stored_user = User::Collection.find_by_email(user_entity.email)

    expect(stored_user.email).to eq(user_entity.email)
  end

  xit 'returns errors if the user is not valid' do
    invalid_user = User::Entity.new(
      public_key: 'key',
      password_hash: 'hash',
      encrypted_private_key: 'encrypted'
    )

    User::Collection.persist(user_entity)
    stored_user = User::Collection.find_by_email(user_entity.email)

    expect(stored_user.email).to eq(user_entity.email)
  end
end
