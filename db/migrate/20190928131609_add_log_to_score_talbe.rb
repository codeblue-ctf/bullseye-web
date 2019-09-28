class AddLogToScoreTalbe < ActiveRecord::Migration[5.2]
  def change
    rename_column :scores, :image_id, :image_digest
    add_column :scores, :log, :text
  end
end
