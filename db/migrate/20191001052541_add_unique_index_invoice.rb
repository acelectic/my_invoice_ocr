class AddUniqueIndexInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_index :invoices, :invoice_no, unique: true, name: "idx_invoices_unique_index"
    #Ex:- add_index("admin_users", "username")

  end

  def down
    remove_index :invoices, name: "idx_invoices_unique_index"
  end

end
