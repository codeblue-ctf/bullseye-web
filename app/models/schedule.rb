class Schedule < ApplicationRecord
  belongs_to :team
  belongs_to :problem
  has_many :schedule_result

  after_save do |record|
    is_new = record.created_at == record.updated_at
    if is_new or record.next_jobid_changed? then
      ScheduleWorker.perform_async record.id
    end
  end

  before_destroy do |record|
    if record.schedule_result.size > 0 then
      raise ActiveRecord::ReadOnlyRecord, "update finish_at value to stop executed schedule"
    end
  end
end
