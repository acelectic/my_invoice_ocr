class DropTableMsInvoice < ActiveRecord::Migration[6.0]
  def change
    drop_table :ms_invoices
  end
end
