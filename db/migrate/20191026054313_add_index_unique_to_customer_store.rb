class AddIndexUniqueToCustomerStore < ActiveRecord::Migration[6.0]
  
  def up
    add_index :customer_stores, [:customer_store_code], name: "index_customer_stores_unique", unique: true
  end

  def down
    remove_index :customer_stores, name: "index_customer_stores_unique"
  end

end
