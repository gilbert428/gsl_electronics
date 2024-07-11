class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes do |t|
      t.string :province
      t.decimal :gst_rate
      t.decimal :pst_rate

      t.timestamps
    end
  end
end
