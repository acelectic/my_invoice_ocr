class AddIndexToTrInvoice < ActiveRecord::Migration[6.0]
 
  def up
    add_index :tr_invoices, :ocr_date, name: "index_tr_invoices_ocr_date"
    add_index :tr_invoices, [:ocr_date, :ocr_result], name: "index_tr_invoices_ocr_date_and_ocr_result"
  end

  def down
    remove_index :tr_invoices, name: "index_tr_invoices_ocr_date"
    remove_index :tr_invoices, name: "index_tr_invoices_ocr_date_and_ocr_result"
  end

end
