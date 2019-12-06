class ChangeTypeItemIdToIntegerInMsInvoiceItem < ActiveRecord::Migration[6.0]
  
  def up
    change_column :ms_invoice_items, :item_id, :integer
  end

  def down
    change_column :ms_invoice_items, :item_id, :string
  end
end
