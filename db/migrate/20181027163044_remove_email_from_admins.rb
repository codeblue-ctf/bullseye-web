class RemoveEmailFromAdmins < ActiveRecord::Migration[5.2]
  def change
    remove_column :admins, :email, :string
  end
end
