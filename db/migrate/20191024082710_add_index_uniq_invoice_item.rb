class AddIndexUniqInvoiceItem < ActiveRecord::Migration[6.0]
 
  def up
    add_index :tr_invoice_items, [:invoice_sequence, :ms_invoice_item_id, :tr_invoice_id], name: "index_tr_invoice_items_unique", unique: true
  end

  def down
    remove_index :tr_invoice_items, name: "index_tr_invoice_items_unique"
  end
end
