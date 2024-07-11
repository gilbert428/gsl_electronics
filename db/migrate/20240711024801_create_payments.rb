class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.string :payment_method
      t.decimal :amount
      t.datetime :payment_date
      t.integer :card_number
      t.datetime :card_expiry
      t.integer :card_cvv

      t.timestamps
    end
  end
end
