# == Schema Information
#
# Table name: customer_stores
#
#  id                  :bigint           not null, primary key
#  assign_branch_name  :string(100)
#  customer_store_code :string(255)      not null
#  customer_store_name :string(255)
#  customer_store_type :string(1)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  customer_id         :integer          not null
#
# Indexes
#
#  index_customer_stores_unique  (customer_store_code) UNIQUE
#

class CustomerStore < ApplicationRecord
	include SyncableModel

	has_many :ms_invoices
	has_many :ocr_invoices
	
	belongs_to :customer

	def self.get_hash
		create_hash(all , "customer_store_code", "class")
	end

	def customer_store_type_name
		case customer_store_type
			when "O" then "Owner"
			when "F" then "Franchise"
			when "H" then "Headquarter"
			else ""
		end
	end

	def self.map_data(job_id = nil, job_name = nil)
		db_sale_quey_count    = 0
		smart_dc_insert_count = 0
		event_start_date = DateTime.now
		error = nil
		start_sync_time = DbsaleCustomerAddress.maximum(:last_upd_date)

		# condition = last_synced_at == default_last_sync ? ""
		# : "AND NVL(CUSTOMER_ADDRESSES.LAST_UPD_DATE, TO_DATE('31/12/2999', 'DD/MM/YYYY')) > #{last_synced_at.to_date.wrap_oracle_to_date_time}"

		customers = Customer.get_hash
		query = DbsaleCustomerAddress.all

		begin
			query.find_in_batches(batch_size:4000).with_index do |cust_addresses, batch|
				customer_stores = []
				cust_addresses.each do |address|
					db_sale_quey_count = db_sale_quey_count + 1

					customer_id = customers[address.p_cust_code]
					next if customer_id.nil?

					customer_store = CustomerStore.new(
						customer_id:         customer_id,						
						customer_store_code: address.customer_code,
						customer_store_name: address.customer_name_in_thai,
						assign_branch_name:  address.branch_name,
						customer_store_type: address.type_of_business
					)
					customer_stores << customer_store
				end

				CustomerStore.import(
					customer_stores,
					on_duplicate_key_update: CustomerStore.column_names - ['id', 'customer_store_code'],
					validate: false,
					batch_size: 2000,
				)
				smart_dc_insert_count = smart_dc_insert_count + customer_stores.size
			end
		rescue Exception => exception
			error = exception.message
		end

		# CustomerStore.last_synced_at = start_sync_time
		event_end_date = DateTime.now

		CustomerStore.log_message(
			job_id,
			job_name,
			DbsaleCustomerAddress.event_table_name,
			db_sale_quey_count,
			CustomerStore.event_table_name,
			smart_dc_insert_count,
			query,
			event_start_date,
			event_end_date,
			true,
			error
		)
	end

	def display_name
    if customer.customer_short_name.present?
      "#{customer.customer_short_name} #{assign_branch_name}"
    else
      "#{customer_store_name} #{assign_branch_name}"
    end
  end
end
