class Schedule < ApplicationRecord
  belongs_to :team
  belongs_to :problem

  after_save do |record|
    ScheduleWorker.perform_async record.id
  end
end
