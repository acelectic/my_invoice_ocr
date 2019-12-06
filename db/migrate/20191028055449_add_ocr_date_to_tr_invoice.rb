class AddOcrDateToTrInvoice < ActiveRecord::Migration[6.0]
  
  def up
    remove_index :tr_invoices, name: "index_tr_invoices_unique"

    add_column :tr_invoices, :ocr_date, :date, null: false
    add_index  :tr_invoices, [:ocr_date, :ms_invoice_id, :ocr_invoice_id], name: "index_customers_unique", unique: true
  end

  def down
    remove_index :tr_invoices, name: "index_tr_invoices_unique"

    remove_column :tr_invoices, :ocr_date
    add_index  :tr_invoices, [:ms_invoice_id, :ocr_invoice_id], name: "index_customers_unique", unique: true
  end
end
