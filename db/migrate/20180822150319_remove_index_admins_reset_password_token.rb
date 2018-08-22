class RemoveIndexAdminsResetPasswordToken < ActiveRecord::Migration[5.2]
  def change
    remove_index :admins, name: :index_admins_on_reset_password_token
  end
end
