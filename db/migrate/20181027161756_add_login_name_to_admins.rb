class AddLoginNameToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :login_name, :string
    add_index :admins, :login_name, unique: true
  end
end
