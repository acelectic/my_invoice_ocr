class AddCustomerStoreTypeInCustomerStore < ActiveRecord::Migration[6.0]
 
  def up
    add_column :customer_stores, :customer_store_type, :string, limit: 1
  end

  def down
    remove :customer_stores, :customer_store_type
  end

end
