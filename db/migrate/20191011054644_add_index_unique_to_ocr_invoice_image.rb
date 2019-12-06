class AddIndexUniqueToOcrInvoiceImage < ActiveRecord::Migration[6.0]
  
  def up
    add_index :ocr_invoice_images, [:ocr_invoice_id, :ocr_date, :image_name, :page], name: "index_ocr_invoice_images_unique", unique: true
  end

  def down
    remove_index :ocr_invoice_images, name: "index_ocr_invoice_images_unique"
  end
end
