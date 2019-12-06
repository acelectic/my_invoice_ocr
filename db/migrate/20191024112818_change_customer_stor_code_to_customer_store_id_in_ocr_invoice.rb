class ChangeCustomerStorCodeToCustomerStoreIdInOcrInvoice < ActiveRecord::Migration[6.0]
  
  def up
    remove_index :ocr_invoices, name: "index_ocr_invoices_unique"
    remove_column :ocr_invoices, :customer_store_code
    
    add_column :ocr_invoices, :customer_store_id, :integer, null: false
    add_index :ocr_invoices, [:ocr_date, :customer_store_id, :vat_no], name: "index_ocr_invoices_unique", unique: true
  end

  def down
    remove_index :ocr_invoices, name: "index_ocr_invoices_unique"
    remove_column :ocr_invoices, :customer_store_id
    
    add_column :ocr_invoices, :customer_store_code, :integer, null: false
    add_index :ocr_invoices, [:ocr_date, :customer_store_code, :vat_no], name: "index_ocr_invoices_unique", unique: true
  end
end
