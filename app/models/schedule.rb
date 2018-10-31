class Schedule < ApplicationRecord
  belongs_to :team
  belongs_to :problem
  has_many :schedule_result

  after_save do |record|
    next_jobid = record.next_jobid

    if next_jobid
      job = Sidekiq::ScheduledSet.new.find_job(next_jobid)
      job.delete if job
    end

    next_jobid = ScheduleWorker.perform_async record.id
    record.update_columns(next_jobid: next_jobid)
  end

  before_destroy do |record|
    if record.schedule_result.size > 0 then
      raise ActiveRecord::ReadOnlyRecord, "update finish_at value to stop executed schedule"
    end
  end
end
