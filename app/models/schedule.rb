class Schedule < ApplicationRecord
  belongs_to :team
  belongs_to :problem

  after_save do |record|
    if record.next_jobid_changed? then
      ScheduleWorker.perform_async record.id
    end
  end

  before_destroy do |record|
    raise ActiveRecord::ReadOnlyRecord, "update finish_at value to stop schedule"
  end
end
