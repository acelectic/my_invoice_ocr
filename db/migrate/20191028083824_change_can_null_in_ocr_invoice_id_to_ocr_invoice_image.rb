class ChangeCanNullInOcrInvoiceIdToOcrInvoiceImage < ActiveRecord::Migration[6.0]
  
  def up
    change_column_null(:ocr_invoice_images, :ocr_invoice_id, true)
  end

  def down
    change_column_null(:ocr_invoice_images, :ocr_invoice_id, false)
  end

end
