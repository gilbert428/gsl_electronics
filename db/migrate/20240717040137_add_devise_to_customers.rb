class AddDeviseToCustomers < ActiveRecord::Migration[6.1]
  def up
    change_table :customers do |t|
      ## Database authenticatable
      t.change :email, :string, null: false, default: "" unless column_exists?(:customers, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:customers, :encrypted_password)

      ## Recoverable
      t.string   :reset_password_token unless column_exists?(:customers, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:customers, :reset_password_sent_at)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:customers, :remember_created_at)

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false unless column_exists?(:customers, :sign_in_count)
      t.datetime :current_sign_in_at unless column_exists?(:customers, :current_sign_in_at)
      t.datetime :last_sign_in_at unless column_exists?(:customers, :last_sign_in_at)
      t.string   :current_sign_in_ip unless column_exists?(:customers, :current_sign_in_ip)
      t.string   :last_sign_in_ip unless column_exists?(:customers, :last_sign_in_ip)

      ## Confirmable
      # t.string   :confirmation_token unless column_exists?(:customers, :confirmation_token)
      # t.datetime :confirmed_at unless column_exists?(:customers, :confirmed_at)
      # t.datetime :confirmation_sent_at unless column_exists?(:customers, :confirmation_sent_at)
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false unless column_exists?(:customers, :failed_attempts)
      # t.string   :unlock_token unless column_exists?(:customers, :unlock_token)
      # t.datetime :locked_at unless column_exists?(:customers, :locked_at)
    end

    add_index :customers, :email,                unique: true unless index_exists?(:customers, :email)
    add_index :customers, :reset_password_token, unique: true unless index_exists?(:customers, :reset_password_token)
    # add_index :customers, :confirmation_token,   unique: true
    # add_index :customers, :unlock_token,         unique: true
  end

  def down
    # Remove the columns if you want to revert the migration
    change_table :customers do |t|
      t.remove :encrypted_password if column_exists?(:customers, :encrypted_password)
      t.remove :reset_password_token if column_exists?(:customers, :reset_password_token)
      t.remove :reset_password_sent_at if column_exists?(:customers, :reset_password_sent_at)
      t.remove :remember_created_at if column_exists?(:customers, :remember_created_at)
      t.remove :sign_in_count if column_exists?(:customers, :sign_in_count)
      t.remove :current_sign_in_at if column_exists?(:customers, :current_sign_in_at)
      t.remove :last_sign_in_at if column_exists?(:customers, :last_sign_in_at)
      t.remove :current_sign_in_ip if column_exists?(:customers, :current_sign_in_ip)
      t.remove :last_sign_in_ip if column_exists?(:customers, :last_sign_in_ip)
      # t.remove :confirmation_token if column_exists?(:customers, :confirmation_token)
      # t.remove :confirmed_at if column_exists?(:customers, :confirmed_at)
      # t.remove :confirmation_sent_at if column_exists?(:customers, :confirmation_sent_at)
      # t.remove :unconfirmed_email if column_exists?(:customers, :unconfirmed_email)
      # t.remove :failed_attempts if column_exists?(:customers, :failed_attempts)
      # t.remove :unlock_token if column_exists?(:customers, :unlock_token)
      # t.remove :locked_at if column_exists?(:customers, :locked_at)
    end
  end
end
