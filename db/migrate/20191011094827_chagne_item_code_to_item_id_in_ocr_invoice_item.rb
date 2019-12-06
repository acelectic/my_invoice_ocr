class ChagneItemCodeToItemIdInOcrInvoiceItem < ActiveRecord::Migration[6.0]
  
  def up
    remove_column :ocr_invoice_items, :item_code
    add_column    :ocr_invoice_items, :item_id, :integer, null: false

    remove_index  :ocr_invoice_items, name: "index_ocr_invoice_items_unique"
    add_index     :ocr_invoice_items, [:ocr_invoice_id, :item_id], name: "index_ocr_invoice_items_unique", unique: true
  end

  def down
    remove_column :ocr_invoice_items, :item_id
    add_column    :ocr_invoice_items, :item_code, :string

    remove_index  :ocr_invoice_items, name: "index_ocr_invoice_items_unique"
    add_index     :ocr_invoice_items, [:ocr_invoice_id, :item_code], name: "index_ocr_invoice_items_unique", unique: true
  end
end
