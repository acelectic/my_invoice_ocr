class ChangeCustomerStorCodeToCustomerStoreIdInMsInvoice < ActiveRecord::Migration[6.0]
 
  def up
    remove_column :ms_invoices, :customer_store_code
    add_column :ms_invoices, :customer_store_id, :integer, null: false
   
  end

  def down
    remove_column :ms_invoices, :customer_store_id
    add_column :ms_invoices, :customer_store_code, :integer, null: false
  end

end
