# frozen_string_literal: true

class AddDeviseToAdminUsers < ActiveRecord::Migration[7.1]
  def self.up
    change_table :admin_users, bulk: true do |t|
      ## Database authenticatable
      unless column_exists? :admin_users, :encrypted_password
        t.string :encrypted_password, null: false, default: ""
      end

      ## Recoverable
      unless column_exists? :admin_users, :reset_password_token
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at
      end

      ## Rememberable
      unless column_exists? :admin_users, :remember_created_at
        t.datetime :remember_created_at
      end

      ## Trackable
      # unless column_exists? :admin_users, :sign_in_count
      #   t.integer  :sign_in_count, default: 0, null: false
      #   t.datetime :current_sign_in_at
      #   t.datetime :last_sign_in_at
      #   t.string   :current_sign_in_ip
      #   t.string   :last_sign_in_ip
      # end

      ## Confirmable
      # unless column_exists? :admin_users, :confirmation_token
      #   t.string   :confirmation_token
      #   t.datetime :confirmed_at
      #   t.datetime :confirmation_sent_at
      #   t.string   :unconfirmed_email # Only if using reconfirmable
      # end

      ## Lockable
      # unless column_exists? :admin_users, :failed_attempts
      #   t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      #   t.string   :unlock_token # Only if unlock strategy is :email or :both
      #   t.datetime :locked_at
      # end

      # Uncomment below if timestamps were not included in your original model.
      # unless column_exists? :admin_users, :created_at
      #   t.timestamps null: false
      # end
    end

    add_index :admin_users, :email, unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
    # add_index :admin_users, :confirmation_token, unique: true unless index_exists?(:admin_users, :confirmation_token)
    # add_index :admin_users, :unlock_token, unique: true unless index_exists?(:admin_users, :unlock_token)
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
