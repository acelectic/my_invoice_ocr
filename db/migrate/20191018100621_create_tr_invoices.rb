class CreateTrInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :tr_invoices do |t|

      t.integer :ms_invoice_id,  null: false
      t.integer :ocr_invoice_id, null: false
      t.boolean :ocr_result,     null: false
      t.string  :ocr_status
      t.timestamps

    end
  end
end
