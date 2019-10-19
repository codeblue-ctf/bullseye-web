class DeviseTokenAuthCreateTeams < ActiveRecord::Migration[5.2]
  def change
    
    #create_table(:teams) do |t|
      ## Required
      add_column :teams, :provider, :string, :null => false, :default => "email"
      add_column :teams, :uid, :string, :null => false, :default => ""

      ## Database authenticatable
      #t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      #t.string   :reset_password_token
      #t.datetime :reset_password_sent_at
      #t.boolean  :allow_password_change, :default => false

      ## Rememberable
      #t.datetime :remember_created_at

      ## Confirmable
      #t.string   :confirmation_token
      #t.datetime :confirmed_at
      #t.datetime :confirmation_sent_at
      #t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      #t.string :name
      #t.string :nickname
      #t.string :image
      #t.string :email

      ## Tokens
      add_column :teams, :tokens, :text

      #t.timestamps
    #end

    #add_index :teams, :email,                unique: true
    add_index :teams, [:uid, :provider],     unique: true
    #add_index :teams, :reset_password_token, unique: true
    #add_index :teams, :confirmation_token,   unique: true
    # add_index :teams, :unlock_token,       unique: true
  end
end
