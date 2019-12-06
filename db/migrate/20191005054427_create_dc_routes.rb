class CreateDcRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :dc_routes do |t|

      t.integer :distribution_center_id, null: false
      t.string  :dc_route_code,          limit: 10, null: false
      t.string  :dc_route_name,          limit: 80, null: false
      t.boolean :is_factory             
      t.string  :operation_type,         limit: 50
      t.integer :plant_id               
      t.string  :customer_branch_code,   limit: 5
      t.string  :building_code,          limit: 10
      t.boolean :is_active,              null: false, default: true
      t.timestamps

    end
  end
end
