class Schedule < ApplicationRecord
  belongs_to :team
  belongs_to :problem
  has_many :schedule_result

  after_save do |record|
    delete_job(record.id)
    ScheduleWorker.perform_async record.id
  end

  before_destroy do |record|
    if record.schedule_result.size > 0 then
      raise ActiveRecord::ReadOnlyRecord, "update finish_at value to stop executed schedule"
    end
  end

  def delete_job(schedule_id)
    Sidekiq::ScheduledSet.new.select do |job|
      if job.args[0] == schedule_id
        job.delete
      end
    end
  end
end
