class User < ActiveRecord::Base
  has_many :authorizations
  has_many :credentials, through: :authorizations
end
