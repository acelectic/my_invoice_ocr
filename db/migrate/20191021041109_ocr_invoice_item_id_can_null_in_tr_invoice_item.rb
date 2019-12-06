class OcrInvoiceItemIdCanNullInTrInvoiceItem < ActiveRecord::Migration[6.0]
  
  def up
    change_column_null(:tr_invoice_items, :ocr_invoice_item_id, true)
  end

  def down
    change_column_null(:tr_invoice_items, :ocr_invoice_item_id, false)
  end
  
end
