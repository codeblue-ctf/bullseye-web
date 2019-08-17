class Team < ApplicationRecord
  has_many :schedule
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, :omniauthable,
         authentication_keys: [:login_name]
  include DeviseTokenAuth::Concerns::User
end
