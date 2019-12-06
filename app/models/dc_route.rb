# == Schema Information
#
# Table name: dc_routes
#
#  id                     :bigint           not null, primary key
#  building_code          :string(10)
#  customer_branch_code   :string(5)
#  dc_route_code          :string(10)       not null
#  dc_route_name          :string(80)       not null
#  is_active              :boolean          default(TRUE), not null
#  is_factory             :boolean
#  operation_type         :string(50)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  distribution_center_id :integer          not null
#  plant_id               :integer
#
# Indexes
#
#  index_dc_routes_on_dc_route_code           (dc_route_code) UNIQUE
#  index_dc_routes_on_distribution_center_id  (distribution_center_id)
#

class DcRoute < ApplicationRecord
    include SyncableModel
    include VisibilityScopeableModel

    belongs_to :distribution_center

    def self.get_hash
      create_hash(all.includes(:distribution_center), "dc_route_code", "class")
    end

    def self.map_data(job_id = nil, job_name = nil)
      start_sync_time = DbsaleStore.maximum(:last_upd_date)
  
      db_sale_quey_count    = 0
      smart_dc_insert_count = 0
      event_start_date = DateTime.now
      error = nil
  
      query = DbsaleStore.where.not(record_type: 'F')
        .joins("INNER JOIN DEPARTMENT_ADDRESSES ON DEPARTMENT_ADDRESSES.DEPARTMENT_CODE = SUBSTR(STORES.STORE_ID,1,4)")
  
      distribution_center_hash = DcRoute.create_hash(DistributionCenter.all, "distribution_center_code")
  
      begin
        query.find_in_batches(batch_size: 2000).with_index do |store_group, batch|
          dc_routes = []
  
          store_group.each do |store|
            db_sale_quey_count = db_sale_quey_count + 1
  
            distribution_center_id = distribution_center_hash[store.department_code]
            next if distribution_center_id.nil?
  
            operation_type = ''
            case store.type_store
            when 'R'
              operation_type = 'Return'
            when 'P'
              operation_type = 'Production'
            when 'D'
              operation_type = 'Delivery'
            else
              operation_type = 'Other'
            end
  
            dc_route = DcRoute.new(
              distribution_center_id: distribution_center_id,
              dc_route_code:          store.store_id,
              dc_route_name:          store.description,
              is_active:              store.status == 'A',
              operation_type:         operation_type,
              is_factory:             store.record_type == 'F',
              customer_branch_code:   store.branch_code,
              building_code:          store.building_code
            )
  
            dc_routes << dc_route
          end
  
          DcRoute.import(
            dc_routes,
            on_duplicate_key_update: DcRoute.column_names - ['id', 'dc_route_code'],
            validate: false,
            batch_size: 500
          )
  
          smart_dc_insert_count = smart_dc_insert_count + dc_routes.size
  
          # DcRoute.includes(:dc_routes_sub_business_types).where(dc_route_code: dc_routes.map(&:dc_route_code)).reindex
        end
      rescue Exception => exception
        error = exception.message
      end
  
      # DcRoute.last_synced_at = start_sync_time
      event_end_date = Time.now
  
      DcRoute.log_message(
        job_id,
        job_name,
        DbsaleStore.event_table_name,
        db_sale_quey_count,
        DcRoute.event_table_name,
        smart_dc_insert_count,
        query,
        event_start_date,
        event_end_date,
        true,
        error
      )
    end
end
