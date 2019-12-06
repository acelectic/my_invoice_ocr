# == Schema Information
#
# Table name: ms_invoices
#
#  id                     :bigint           not null, primary key
#  branch_seq             :string(2)
#  invoice_date           :date
#  total_cost             :decimal(16, 2)   default(0.0)
#  vat_invoice_number     :string(22)       not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  customer_store_id      :integer          not null
#  dc_route_id            :string(10)
#  distribution_center_id :integer          not null
#  invoice_id             :string(255)      not null
#
# Indexes
#
#  index_ms_invoice_on_vat_invoice_number  (vat_invoice_number) UNIQUE
#  index_ms_invoices_vat_invoice_number    (vat_invoice_number)
#

class MsInvoice < ActiveRecord::Base
  include SyncableModel

  has_one :tr_invoice
  has_many :ms_invoice_items
  has_many :items, through: :ms_invoice_items

  belongs_to :dc_route
  belongs_to :customer_store
  belongs_to :distribution_center

  delegate :customer_store_type_name, to: :customer_store
  delegate :customer_store_code,      to: :customer_store
  delegate :display_name,             to: :customer_store
  delegate :dc_route_code,            to: :dc_route
  
  def self.get_hash(vat_no)
    create_hash(where(vat_invoice_number: vat_no).includes(:ms_invoice_items), ["vat_invoice_number", "branch_seq", "customer_store_id"], "class")
  end

  #require table data form customer_stores_sub_business_types
  def self.map_data(job_id = nil, job_name = nil)
    db_sale_quey_count    = 0
    smart_dc_insert_count = 0
    event_start_date = DateTime.now
    error = nil


    dc_routes       = DcRoute.get_hash
    customer_stores = CustomerStore.get_hash
    #fix ค่าไว้ก่อน รออะไรซักอย่าง
    query = DbsaleInvoice.all

      query.find_in_batches(batch_size: 2000) do |records|
        save_list = []
        records.each do |tmp_invoice|
          db_sale_quey_count += 1

          customer_store    = customer_stores[tmp_invoice.customer_code]
          next if customer_store.nil?
          customer_store_id = customer_store.id

          dc_route               = dc_routes[tmp_invoice.store_id]
          next if dc_route.nil?
          dc_route_id            = dc_route.id
          distribution_center_id = dc_route.distribution_center.id
          
          save_list << MsInvoice.new(
            invoice_id:               tmp_invoice.invoice_id,
            invoice_date:             tmp_invoice.invoice_date,
            vat_invoice_number:       tmp_invoice.vat_invoice_no,         
            customer_store_id:        customer_store_id,       
            total_cost:               tmp_invoice.net_invoice_value_baht,            
            dc_route_id:              dc_route_id,
            distribution_center_id:   distribution_center_id,           
            branch_seq:               tmp_invoice.dept_seq,           
          )
        end
        import(
          save_list,
          on_duplicate_key_update: MsInvoice.column_names - ['id', 'invoice_id'],
          validate: false,
          batch_size: 1000,
        )
        smart_dc_insert_count += save_list.size
      end
      # MsInvoice.last_synced_at = DbsaleInvoice.maximum(:last_upd_date)
    # rescue Exception => exception
    #   error = exception.message
    # end

    event_end_date = DateTime.now

    log_message(
      job_id,
      job_name,
      DbsaleInvoice.event_table_name,
      db_sale_quey_count,
      event_table_name,
      smart_dc_insert_count,
      query,
      event_start_date,
      event_end_date,
      true,
      error
    )
  end

end
  
