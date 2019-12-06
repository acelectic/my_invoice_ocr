class AddIndexUniqueToCustomer < ActiveRecord::Migration[6.0]
  
  def up
    add_index :customers, [:customer_code], name: "index_customers_unique", unique: true
  end

  def down
    remove_index :customers, name: "index_customers_unique"
  end

end