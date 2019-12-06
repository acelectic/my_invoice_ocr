class AddIndexInDcroute < ActiveRecord::Migration[6.0]
  def up
    add_index :dc_routes, [:dc_route_code], name: "index_dc_routes_on_dc_route_code", unique: true
    add_index :dc_routes, [:distribution_center_id], name: "index_dc_routes_on_distribution_center_id"
  end

  def down
    remove_index :dc_routes, name: "index_dc_routes_on_dc_route_code"
    remove_index :dc_routes, name: "index_dc_routes_on_distribution_center_id"
  end
end
