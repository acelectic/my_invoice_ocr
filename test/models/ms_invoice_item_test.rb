# == Schema Information
#
# Table name: ms_invoice_items
#
#  id            :bigint           not null, primary key
#  seq_no        :integer
#  value         :float(24)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  invoice_id    :bigint
#  item_id       :integer
#  ms_invoice_id :bigint
#
# Indexes
#
#  index_ms_invoice_items_unique  (ms_invoice_id,item_id) UNIQUE
#

require 'test_helper'

class MsInvoiceItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
