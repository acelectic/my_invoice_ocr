# == Schema Information
#
# Table name: ocr_invoices
#
#  id                :bigint           not null, primary key
#  is_compared       :boolean          default(FALSE), not null
#  net_price         :float(24)
#  ocr_date          :date             not null
#  sequence          :integer
#  status            :string(255)
#  total_page        :float(24)
#  vat_no            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  customer_store_id :integer          not null
#
# Indexes
#
#  index_ocr_invoices_ocr_date  (ocr_date)
#  index_ocr_invoices_unique    (ocr_date,customer_store_id,vat_no) UNIQUE
#

require 'test_helper'

class OcrInvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
