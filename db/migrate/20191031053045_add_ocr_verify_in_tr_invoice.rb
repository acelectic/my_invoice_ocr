class AddOcrVerifyInTrInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_column :tr_invoices, :ocr_verify, :boolean
  end

  def down
    remove_column :tr_invoices, :ocr_verify
  end

end
