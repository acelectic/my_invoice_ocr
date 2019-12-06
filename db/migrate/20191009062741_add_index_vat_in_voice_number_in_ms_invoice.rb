class AddIndexVatInVoiceNumberInMsInvoice < ActiveRecord::Migration[6.0]
  def up
    add_index :ms_invoices, [:vat_invoice_number], name: "index_ms_invoice_on_vat_invoice_number", unique: true
  end

  def down
    remove_index :ms_invoices, name: "index_ms_invoice_on_vat_invoice_number"
  end
end
