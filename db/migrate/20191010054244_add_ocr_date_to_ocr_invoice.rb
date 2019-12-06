class AddOcrDateToOcrInvoice < ActiveRecord::Migration[6.0]
  
  def up
    add_column :ocr_invoices, :ocr_date, :date, null: false
  end

  def down
    remove_column :ocr_invoices, :ocr_date
  end
end
