class Schedule < ApplicationRecord
  after_create :send_create_notification
  after_destroy :send_destroy_notification

  def send_create_notification
    # XXX: masterとの通信に失敗したら通知する必要あり？
    RunnerMaster::create_schedule(self)
  end
  def send_destroy_notification(schedule)
    # XXX: masterとの通信に失敗したら通知する必要あり？
    RunnerMaster::delete_schedule(schedule.id)
  end
end
