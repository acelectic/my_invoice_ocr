class CreateDistributionCenters < ActiveRecord::Migration[6.0]
  def change
    create_table :distribution_centers do |t|

      t.string :distribution_center_code, limit: 6,  null: false
      t.string :distribution_center_name, limit: 50, null: false
      t.string :distribution_center_type, limit: 1
      t.string :description,              limit: 100
      t.string :account_ref_code,         limit: 30
      t.string :invoice_ref_code,         limit: 30
      t.string :forecast_ref_code,        limit: 10
      t.string :postal_code,              limit: 10
      t.string :first_digit_dc_code,      limit: 1,  null: false, default: "1"
      t.integer :region_id                
      t.integer :province_id              
      t.integer :amphoe_id                
      t.integer :tambon_id                
      t.boolean :is_register              
      t.integer :sale_zone_id             
      t.integer :sub_sale_zone_id         
      t.integer :tambon_postal_code_id
      t.boolean :is_active
      
      t.timestamps
    end
  end
end
