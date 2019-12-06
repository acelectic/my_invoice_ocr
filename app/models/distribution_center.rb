# == Schema Information
#
# Table name: distribution_centers
#
#  id                       :bigint           not null, primary key
#  distribution_center_code :string(6)        not null
#  distribution_center_name :string(50)       not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  sale_zone_id             :integer
#  sub_sale_zone_id         :integer
#
# Indexes
#
#  index_departments_on_code  (distribution_center_code) UNIQUE
#

class DistributionCenter < ApplicationRecord
    # include VisibilityScopeableModel
    include SyncableModel

    has_many :dc_routes
    has_many :ms_invoices
    has_many :tr_invoices,      through: :ms_invoices
    has_many :tr_invoice_items, through: :tr_invoices
    
    def self.invoices_with_date(start_date)
      conditions = { tr_invoices: { ocr_date: start_date }.compact }.compact
      perform_invoices_with_date(conditions)
    end

    def self.invoices_with_date_range(start_date, end_date)
      conditions = ""

      if (start_date.nil? and end_date.nil?) or (!start_date.nil? and !end_date.nil?)
        conditions += "tr_invoices.ocr_date between '#{start_date}' and '#{end_date}'"
      elsif end_date.nil? 
        conditions += "tr_invoices.ocr_date >= '#{start_date}'"
      elsif start_date.nil?
        conditions += "tr_invoices.ocr_date <= '#{end_date}'"
      end

      perform_invoices_with_date(conditions)
    end

    def self.perform_invoices_with_date(conditions)
      all
      .joins(:tr_invoices)
      .where(conditions)
      .includes(:tr_invoices)
    end

    def self.map_data(job_id = nil, job_name = nil)
        unique_keys = ['id', 'distribution_center_code']
    
        start_sync_time = DbsaleDepartment.maximum(:last_upd_date)
    
        db_sale_quey_count    = 0
        smart_dc_insert_count = 0
        event_start_date = DateTime.now
        error = nil
        query = DbsaleDepartment.joins("INNER JOIN DEPARTMENT_ADDRESSES
          ON DEPARTMENTS.DEPARTMENT_CODE = DEPARTMENT_ADDRESSES.DEPARTMENT_CODE")
    
        begin
          query.find_in_batches(batch_size: 3000).with_index do |db_department, batch|
            distribution_centers = []

            department_addresses = DbsaleDepartmentAddress.where(
              department_code: db_department.map(&:department_code).uniq
            )
            department_address_hash = DistributionCenter.create_hash(department_addresses, "department_code", "class")
    
            db_department.each do |department|
              db_sale_quey_count = db_sale_quey_count + 1
              department_address = department_address_hash[department.department_code]
              next if department_address.nil?
    
              region_id = nil
              province_id = nil
              amphoe_id = nil
              tambon_id = nil
    
    
              distribution_center = DistributionCenter.new(
                distribution_center_code: department.department_code,
                distribution_center_name: department.department_desc
              )
    
              distribution_centers << distribution_center
            end
    
            DistributionCenter.import(
              distribution_centers,
              on_duplicate_key_update: DistributionCenter.column_names - unique_keys,
              validate: false,
              batch_size: 300,
            )
    
            smart_dc_insert_count = smart_dc_insert_count + distribution_centers.size
    
            # DistributionCenter.where(
            #   distribution_center_code: distribution_centers.map(&:distribution_center_code)
            # ).reindex
          end
          # DistributionCenter.last_synced_at = start_sync_time
        rescue Exception => exception
          error = exception.message
        end
    
        event_end_date = DateTime.now
        DistributionCenter.log_message(
          job_id,
          job_name,
          DbsaleDepartment.event_table_name,
          db_sale_quey_count,
          DistributionCenter.event_table_name,
          smart_dc_insert_count,
          query,
          event_start_date,
          event_end_date,
          true,
          error
        )
    end
end
