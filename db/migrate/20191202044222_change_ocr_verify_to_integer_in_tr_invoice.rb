class ChangeOcrVerifyToIntegerInTrInvoice < ActiveRecord::Migration[6.0]
  def up
    remove_column :tr_invoices, :ocr_verify
    add_column :tr_invoices, :validate_reason_id, :integer
   
  end

  def down
    remove_column :tr_invoices, :validate_reason_id
    add_column :tr_invoices, :ocr_verify, :boolean
  end
end
