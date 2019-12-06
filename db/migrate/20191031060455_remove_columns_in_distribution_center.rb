class RemoveColumnsInDistributionCenter < ActiveRecord::Migration[6.0]
  
  def up
    remove_column :distribution_centers, :account_ref_code
    remove_column :distribution_centers, :description
    remove_column :distribution_centers, :distribution_center_type
    remove_column :distribution_centers, :postal_code
    remove_column :distribution_centers, :first_digit_dc_code
    remove_column :distribution_centers, :forecast_ref_code
    remove_column :distribution_centers, :invoice_ref_code
    remove_column :distribution_centers, :is_active
    remove_column :distribution_centers, :is_register
    remove_column :distribution_centers, :amphoe_id
    remove_column :distribution_centers, :province_id
    remove_column :distribution_centers, :tambon_id
    remove_column :distribution_centers, :tambon_postal_code_id
    remove_column :distribution_centers, :region_id
  end

  def down
    add_column :distribution_centers, :postal_code,              :string, limit: 10
    add_column :distribution_centers, :account_ref_code,         :string, limit: 30
    add_column :distribution_centers, :description,              :string, limit: 100
    add_column :distribution_centers, :distribution_center_type, :string, limit: 1
    add_column :distribution_centers, :first_digit_dc_code,      :string, limit: 1
    add_column :distribution_centers, :forecast_ref_code,        :string, limit: 10
    add_column :distribution_centers, :invoice_ref_code,         :string, limit: 30    
    add_column :distribution_centers, :is_active,                :boolean
    add_column :distribution_centers, :is_register,              :boolean
    add_column :distribution_centers, :amphoe_id,                :integer
    add_column :distribution_centers, :province_id,              :integer
    add_column :distribution_centers, :tambon_id,                :integer
    add_column :distribution_centers, :tambon_postal_code_id,    :integer
    add_column :distribution_centers, :region_id,                :integer
  end

end
