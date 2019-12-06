class CreateOcrInvoiceItems < ActiveRecord::Migration[6.0]
  def change
    create_table :ocr_invoice_items do |t|

      t.integer :ocr_invoice_id
      t.string :item_code
      t.string :invoice_sequence
      t.float  :price
      t.float  :page
      t.timestamps
      
    end
  end
end
