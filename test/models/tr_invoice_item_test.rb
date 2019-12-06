# == Schema Information
#
# Table name: tr_invoice_items
#
#  id                  :bigint           not null, primary key
#  invoice_sequence    :integer          not null
#  ocr_item_result     :boolean          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  ms_invoice_item_id  :integer          not null
#  ocr_invoice_item_id :integer
#  tr_invoice_id       :integer          not null
#
# Indexes
#
#  index_tr_invoice_items_unique  (invoice_sequence,ms_invoice_item_id,tr_invoice_id) UNIQUE
#

require 'test_helper'

class TrInvoiceItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
