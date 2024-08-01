class Tax < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst_rate", "hst_rate", "id", "id_value", "province", "pst_rate", "qst_rate", "updated_at"]
  end
  validates :province, :gst_rate, :pst_rate, :hst_rate, :qst_rate, presence: true
end
