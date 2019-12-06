class AddCustomerStoreNameToCustomerStore < ActiveRecord::Migration[6.0]
  
  def up
    add_column :customer_stores, :customer_store_name, :string
  end

  def down
    remove_column :customer_stores, :customer_store_name
  end

end
