# == Schema Information
#
# Table name: ocr_invoice_images
#
#  id             :bigint           not null, primary key
#  full_name      :string(255)      not null
#  image_name     :string(255)      not null
#  ocr_date       :date             not null
#  page           :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ocr_invoice_id :integer
#
# Indexes
#
#  index_ocr_invoice_images_unique  (ocr_invoice_id,ocr_date,image_name,page) UNIQUE
#

require 'test_helper'

class OcrInvoiceImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
