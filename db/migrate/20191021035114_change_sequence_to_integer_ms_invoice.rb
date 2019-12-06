class ChangeSequenceToIntegerMsInvoice < ActiveRecord::Migration[6.0]
  def up
    change_column :ocr_invoices, :sequence, :integer
  end

  def down
    change_column :ocr_invoices, :sequence, :string
  end
end
