class DropTableMsInvoiceItem < ActiveRecord::Migration[6.0]
  def up
    drop_table :ms_invoice_items
  end

  def down
    create_table :invoices do |t|

      t.integer  :invoice_id
      t.string   :invoice_type,           limit: 4
      t.string   :invoice_series,         limit: 8
      t.integer  :invoice_no
      t.datetime :invoice_date           
      t.string   :customer_code,          limit: 1
      t.string   :cost_center_code,       limit: 4
      t.string   :department_code,        limit: 6
      t.string   :salesman_code,          limit: 1
      t.string   :vat_code,               limit: 4
      t.string   :vat_inclusive,          limit: 1
      t.string   :vat_invoice_no,         limit: 2, null: false
      t.decimal  :vat_percent,            precision: 5, scale: 2
      t.decimal  :vat_amount,             precision: 16, scale: 2
      t.string   :price_method,           limit: 8
      t.datetime :invoice_due_date
      t.string   :driver_id,              limit: 15
      t.decimal  :cost_of_goods,          precision: 16, scale: 2
      t.decimal  :other_dis_amount,       precision: 16, scale: 2
      t.decimal  :net_invoice_value_baht, precision: 16, scale: 2
      t.string   :status,                 limit: 1
      t.datetime :delivery_date
      t.string   :type_of_invoice,        limit: 1
      t.string   :store_id,               limit: 10
      t.string   :ref_can_inv,            limit: 1, default: "N"
      t.string   :product_group,          limit: 8
      t.datetime :document_date
      t.string   :type_inv,               limit: 1
      t.string   :dept_seq,               limit: 2
      t.string   :customer_po_number,     limit: 255
      t.string   :po_flag,                limit: 1
      t.string   :hh_time,                limit: 10
      t.decimal  :no_of_bill,             precision: 16, scale:  2
      t.string   :cust_card_id,           limit: 20
      t.string   :branch_no,              limit: 50
      t.string   :tax_id,                 limit: 50
      t.timestamps

    end
  end
end
