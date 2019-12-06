class AddInvoiceDateToMsInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_column :ms_invoices, :invoice_date, :date
  end

  def down
    remove_column :ms_invoices, :invoice_date
  end

end
