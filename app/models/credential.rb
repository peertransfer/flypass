class Credential < ActiveRecord::Base
  has_many :users, through: :credentials
end
