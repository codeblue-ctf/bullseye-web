class Schedule < ApplicationRecord
  belongs_to :team
  belongs_to :problem
  has_many :schedule_result
end
