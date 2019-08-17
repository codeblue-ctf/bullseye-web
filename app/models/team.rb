class Team < ApplicationRecord
  has_many :schedule
  
  devise :database_authenticatable, :trackable, :validatable, :omniauthable, :rememberable,
         authentication_keys: [:login_name]
  include DeviseTokenAuth::Concerns::User
end
