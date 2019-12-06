class AddIndexUniqInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_index :tr_invoices, [:ms_invoice_id, :ocr_invoice_id], name: "index_tr_invoices_unique", unique: true
  end

  def down
    remove_index :tr_invoices, name: "index_tr_invoices_unique"
  end
  
end
