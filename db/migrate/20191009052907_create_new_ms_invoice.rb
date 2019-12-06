class CreateNewMsInvoice < ActiveRecord::Migration[6.0]
  def change
    create_table :ms_invoices do |t|

      t.string     :invoice_id,          null: false
      t.string     :vat_invoice_number,  null: false,    limit: 22  
      t.string     :customer_store_code, limit: 10
      t.decimal    :total_cost,          precision: 16,  scale: 2, default:0.0 
      t.string     :dc_route_id,         limit:  10  
      t.string     :branch_seq,          limit:  2   
      t.timestamps
    end
  end
end

