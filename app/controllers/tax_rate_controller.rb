# app/controllers/tax_rates_controller.rb
class TaxRatesController < ApplicationController
  def index
    province = params[:province]
    tax = Tax.find_by(province: province)

    customer = current_customer  # Assuming you have a method to get the current customer

    render json: {
      gst_rate: tax&.gst_rate || 0,
      pst_rate: tax&.pst_rate || 0,
      hst_rate: tax&.hst_rate || 0,
      qst_rate: tax&.qst_rate || 0,
      customer: {
        email: customer&.email || '',
        name: customer&.name || '',
        address: customer&.address || ''
      }
    }
  end
end
