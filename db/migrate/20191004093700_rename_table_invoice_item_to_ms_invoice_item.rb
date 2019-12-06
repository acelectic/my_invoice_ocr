class RenameTableInvoiceItemToMsInvoiceItem < ActiveRecord::Migration[6.0]
  
  def up
    rename_table :invoice_items, :ms_invoice_items
  end

  def down
    rename_table :ms_invoice_items, :invoice_items
  end
end
