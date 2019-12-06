class CreateOcrInvoiceImages < ActiveRecord::Migration[6.0]
  def change
    create_table :ocr_invoice_images do |t|

      t.integer :ocr_invoice_id, null: false
      t.string  :image_name,     null: false
      t.string  :full_name,      null: false
      t.integer :page,           null: false
      t.date    :ocr_date,       null: false
      t.timestamps
      
    end
  end
end
