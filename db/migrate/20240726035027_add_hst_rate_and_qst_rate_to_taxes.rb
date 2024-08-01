class AddHstRateAndQstRateToTaxes < ActiveRecord::Migration[7.1]
  def change
    add_column :taxes, :hst_rate, :decimal
    add_column :taxes, :qst_rate, :decimal
  end
end
