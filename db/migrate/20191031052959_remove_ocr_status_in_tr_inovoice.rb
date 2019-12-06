class RemoveOcrStatusInTrInovoice < ActiveRecord::Migration[6.0]
  
  def up
    remove_column :tr_invoices, :ocr_status
  end

  def down
    add_column :tr_invoice, :ocr_status, :string
  end

end
