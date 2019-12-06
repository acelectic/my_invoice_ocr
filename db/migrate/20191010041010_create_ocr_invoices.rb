class CreateOcrInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :ocr_invoices do |t|

      t.string :vat_no
      t.string :sequence
      t.string :customer_store_code
      t.string :status
      t.float  :total_page
      t.float  :net_price
      t.timestamps

    end
  end
end
