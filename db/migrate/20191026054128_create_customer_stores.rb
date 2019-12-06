class CreateCustomerStores < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_stores do |t|

      t.string :customer_store_code, null: false
      t.timestamps
    end
  end
end
