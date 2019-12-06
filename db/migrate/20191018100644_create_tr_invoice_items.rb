class CreateTrInvoiceItems < ActiveRecord::Migration[6.0]
  def change
    create_table :tr_invoice_items do |t|

      t.integer :ms_invoice_item_id,  null: false
      t.integer :ocr_invoice_item_id, null: false
      t.integer :invoice_sequence,    null: false
      t.boolean :ocr_item_result,     null: false
      t.timestamps
      
    end
  end
end
