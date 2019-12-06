class RenameTableInvoiceToMsInvoice < ActiveRecord::Migration[6.0]

  def up
    rename_table :invoices, :ms_invoices
  end

  def down
    rename_table :ms_invoices, :invoices
  end

end
