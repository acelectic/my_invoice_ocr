# == Schema Information
#
# Table name: customers
#
#  id                  :bigint           not null, primary key
#  customer_code       :string(10)       not null
#  customer_short_name :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_customers_unique  (customer_code) UNIQUE
#

class Customer < ApplicationRecord
  include SyncableModel

  has_many :customer_store

  def self.get_hash
    create_hash(all, "customer_code")
  end

  def self.map_data(job_id = nil, job_name = nil)
    start_sync_time = DbsaleCustomer.maximum(:last_upd_date)

    db_sale_quey_count    = 0
    smart_dc_insert_count = 0
    event_start_date = DateTime.now
    error = nil
    query = DbsaleCustomer.all

    begin
      query.find_in_batches(batch_size: 3000).with_index do |addresses, batch|

        customers = []

        addresses.each do |address|
          db_sale_quey_count = db_sale_quey_count + 1

          customer = Customer.new(
            customer_code:                    address.customer_code,
            customer_short_name:              address.short_name,
          )

          customers << customer
        end

        Customer.import(
          customers,
          on_duplicate_key_update: Customer.column_names - ['id', 'customer_code'],
          validate: false,
          batch_size: 300,
        )

        smart_dc_insert_count = smart_dc_insert_count + customers.size
      end
    rescue Exception => exception
      error = exception.message
    end

    event_end_date = DateTime.now

    Customer.log_message(
      job_id,
      job_name,
      DbsaleCustomer.event_table_name,
      db_sale_quey_count,
      Customer.event_table_name,
      smart_dc_insert_count,
      query,
      event_start_date,
      event_end_date,
      true,
      error
    )
  end
end
