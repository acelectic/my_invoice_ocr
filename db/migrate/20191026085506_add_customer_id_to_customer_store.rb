class AddCustomerIdToCustomerStore < ActiveRecord::Migration[6.0]
  
  def up
    add_column :customer_stores, :customer_id, :integer, null: false
  end

  def down
    remove_column :customer_stores, :customer_id
  end

end
