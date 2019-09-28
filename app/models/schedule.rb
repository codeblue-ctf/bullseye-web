class Schedule < ApplicationRecord
  after_create :send_create_notification
  after_destroy :send_destroy_notification

  def send_create_notification
    # TODO: send create schedule request to runner-master
    # masterとの通信に失敗したら通知する必要あり？
  end
  def send_destroy_notification
    # TODO: send destroy schedule request to runner-master
    # masterとの通信に失敗したら通知する必要あり？
  end
end
