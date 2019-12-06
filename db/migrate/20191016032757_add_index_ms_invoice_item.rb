class AddIndexMsInvoiceItem < ActiveRecord::Migration[6.0]
  def up
    add_index :ms_invoice_items, [:ms_invoice_id, :item_id], name: "index_ms_invoice_items_unique", unique: true
  end

  def down
    remove_index :ms_invoice_items, name: "index_ms_invoice_items_unique"
  end
end
