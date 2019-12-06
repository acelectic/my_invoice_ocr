class AddIndexInDistributionCenter < ActiveRecord::Migration[6.0]
  
  def up
    add_index :distribution_centers, [:amphoe_id], name: "index_departments_on_amphoe_id"
    add_index :distribution_centers, [:distribution_center_code], name: "index_departments_on_code", unique: true
    add_index :distribution_centers, [:province_id],  name: "index_departments_on_province_id"
    add_index :distribution_centers, [:tambon_id],  name: "index_departments_on_tambon_id"
    add_index :distribution_centers, [:region_id],  name: "index_departments_on_zone_id"
  end

  def down
    remove_index :distribution_centers, name: "index_departments_on_amphoe_id"
    remove_index :distribution_centers, name: "index_departments_on_code"
    remove_index :distribution_centers, name: "index_departments_on_province_id"
    remove_index :distribution_centers, name: "index_departments_on_tambon_id"
    remove_index :distribution_centers, name: "index_departments_on_zone_id"
  end
end
