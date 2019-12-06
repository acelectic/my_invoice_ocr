# == Schema Information
#
# Table name: ms_invoices
#
#  id                     :bigint           not null, primary key
#  branch_seq             :string(2)
#  invoice_date           :date
#  total_cost             :decimal(16, 2)   default(0.0)
#  vat_invoice_number     :string(22)       not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  customer_store_id      :integer          not null
#  dc_route_id            :string(10)
#  distribution_center_id :integer          not null
#  invoice_id             :string(255)      not null
#
# Indexes
#
#  index_ms_invoice_on_vat_invoice_number  (vat_invoice_number) UNIQUE
#  index_ms_invoices_vat_invoice_number    (vat_invoice_number)
#

require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
