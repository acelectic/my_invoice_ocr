class AddIndexUniqueToOcrInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_index :ocr_invoices, [:ocr_date, :customer_store_code, :vat_no], name: "index_ocr_invoices_unique", unique: true
  end

  def down
    remove_index :ocr_invoices, name: "index_ocr_invoices_unique"
  end
end
