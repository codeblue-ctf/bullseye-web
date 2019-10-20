class ChangeEventLogColumnToText < ActiveRecord::Migration[5.2]
  def change
    change_column :images, :event_log, :text
  end
end
