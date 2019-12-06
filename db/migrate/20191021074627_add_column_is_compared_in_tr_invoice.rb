class AddColumnIsComparedInTrInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_column :tr_invoices, :is_compared, :boolean, default: false, null: false
  end

  def down
    remove_column :tr_invoices, is_compareds
  end

end
