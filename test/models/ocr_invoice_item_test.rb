# == Schema Information
#
# Table name: ocr_invoice_items
#
#  id               :bigint           not null, primary key
#  invoice_sequence :string(255)
#  page             :float(24)
#  price            :float(24)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  item_id          :integer          not null
#  ocr_invoice_id   :integer
#
# Indexes
#
#  index_ocr_invoice_items_unique  (ocr_invoice_id,item_id) UNIQUE
#

require 'test_helper'

class OcrInvoiceItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
