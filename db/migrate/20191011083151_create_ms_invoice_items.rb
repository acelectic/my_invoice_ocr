class CreateMsInvoiceItems < ActiveRecord::Migration[6.0]
  def change
    create_table :ms_invoice_items do |t|

      t.bigint  :ms_invoice_id
      t.bigint  :invoice_id         
      t.integer :seq_no                   
      t.string  :item_id, limit: 40
      t.float   :price    
      t.timestamps

    end
  end
end
