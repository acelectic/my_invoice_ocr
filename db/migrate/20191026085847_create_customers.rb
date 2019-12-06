class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|

      t.string :customer_code,      limit: 10, null: false
      t.string :customer_short_name
      
      t.timestamps
    end
  end
end
