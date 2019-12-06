class AddUniqueIndexInvoiceItem < ActiveRecord::Migration[6.0]
  
  def up
    add_index :invoice_items, [:invoice_id, :item_code], unique: true, name: "idx_invoice_items_unique_index"
    #Ex:- add_index("admin_users", "username")
  end

  def down
    remove_index :invoice_items, name: "idx_invoice_items_unique_index"
  end

end
