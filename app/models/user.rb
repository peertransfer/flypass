class User < ActiveRecord::Base
  has_many :credentials, through: :authorizations
end
