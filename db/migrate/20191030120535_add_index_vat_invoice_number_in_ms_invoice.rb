class AddIndexVatInvoiceNumberInMsInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_index :ms_invoices, :vat_invoice_number, name: "index_ms_invoices_vat_invoice_number"
  end

  def down
    remove_index :ms_invoices, name: "index_ms_invoices_vat_invoice_number"    
  end
end
