class Team < ApplicationRecord
  devise :database_authenticatable, :trackable, :validatable, :rememberable,
         authentication_keys: [:login_name]
  include DeviseTokenAuth::Concerns::User
  enum account_type: [:real, :test]
end
