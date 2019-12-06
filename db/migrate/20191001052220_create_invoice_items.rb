class CreateInvoiceItems < ActiveRecord::Migration[6.0]
  def change
    create_table :invoice_items do |t|

      t.integer  :invoice_id               
      t.string   :invoice_type,             limit: 4, null: false
      t.string   :invoice_series,           limit: 8, null: false
      t.integer  :invoice_no
      t.integer  :seq_no
      t.datetime :invoice_date             
      t.string   :item_code,                limit: 40
      t.string   :item_name,                limit: 255
      t.string   :store_id,                 limit: 10
      t.decimal  :item_qty,                 precision: 16, scale: 4
      t.decimal  :price,                    precision: 16, scale: 4
      t.decimal  :value,                    precision: 20, scale: 6
      t.decimal  :net_item_value,           precision: 20, scale: 6
      t.decimal  :net_price,                precision: 20, scale: 6
      t.string   :status,                   limit: 1
      t.decimal  :net_item_value_exclusive, precision: 24, scale: 6
      t.decimal  :net_item_value_baht,      precision: 24, scale: 6
      t.string   :um_code,                  limit: 4
      t.decimal  :foc_qty,                  precision: 16, scale: 4
      t.string   :foc_um,                   limit: 4
      t.integer  :invoice_item_id          
      t.decimal  :vat_amount,               precision: 20, scale: 6
      t.decimal  :rtn_qty_brn,              precision: 16, scale: 4
      t.string   :boi_flag,                 limit: 1
      t.decimal  :long_qty,                 precision: 16, scale: 4
      t.decimal  :prs_qty,                  precision: 16, scale: 4
      t.decimal  :distribute_qty,           precision: 16, scale: 4
      t.decimal  :forecast_qty,             precision: 16, scale: 4
      t.string   :vat_invoice_no,           limit: 22    
      t.decimal  :sale_gen_qty,             precision: 16, scale: 4
      t.decimal  :replace_in_qty,           precision: 16, scale: 4
      t.decimal  :sum_replace_out_qty,      precision: 16, scale: 4
      t.timestamps

    end
  end
end
