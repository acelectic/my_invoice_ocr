class AddDistributionCenterIdToMsInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_column :ms_invoices, :distribution_center_id, :integer, null: false
  end

  def down
    remove_column :ms_invoices, :distribution_center_id
  end
end
