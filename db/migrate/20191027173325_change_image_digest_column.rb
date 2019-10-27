class ChangeImageDigestColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :scores, :image_digest, :string
  end
end
