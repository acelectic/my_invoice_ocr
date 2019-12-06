class AddIndexOcrDateInOcrInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_index :ocr_invoices, :ocr_date, name: "index_ocr_invoices_ocr_date"
  end

  def down
    remove_index :ocr_invoices, name: "index_ocr_invoices_ocr_date"    
  end
end
