# == Schema Information
#
# Table name: tr_invoices
#
#  id                 :bigint           not null, primary key
#  is_compared        :boolean          default(FALSE), not null
#  ocr_date           :date             not null
#  ocr_result         :boolean          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  ms_invoice_id      :integer          not null
#  ocr_invoice_id     :integer          not null
#  validate_reason_id :integer
#
# Indexes
#
#  index_customers_unique                     (ocr_date,ms_invoice_id,ocr_invoice_id) UNIQUE
#  index_tr_invoices_ocr_date                 (ocr_date)
#  index_tr_invoices_ocr_date_and_ocr_result  (ocr_date,ocr_result)
#

require 'test_helper'

class TrInvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
