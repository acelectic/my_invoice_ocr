class AddIndexUniqueInOcrInvoiceItem < ActiveRecord::Migration[6.0]
  
  def up
    add_index :ocr_invoice_items, [:ocr_invoice_id, :item_code], name: "index_ocr_invoice_items_unique", unique: true
  end

  def down
    remove_index :ocr_invoice_items, name: "index_ocr_invoice_items_unique"
  end
  
end
