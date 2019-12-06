class AddTrInvoiceIdInTrInvoiceItem < ActiveRecord::Migration[6.0]
  
  def up
    add_column :tr_invoice_items, :tr_invoice_id, :integer, null: false
  end

  def down
    remove_column :tr_invoice_items, :tr_invoice_id
  end
end
