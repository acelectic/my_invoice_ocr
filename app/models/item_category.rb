# == Schema Information
#
# Table name: item_categories
#
#  id                 :bigint           not null, primary key
#  alternate_name     :string(20)
#  is_active          :boolean          default(TRUE), not null
#  item_category_code :string(10)       not null
#  item_category_name :string(50)       not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_item_categories_on_item_cat_code  (item_category_code) UNIQUE
#

class ItemCategory < ActiveRecord::Base
    include SyncableModel
  
    has_many :item_sub_categories, dependent: :destroy
    has_many :trays
  
    def self.map_data(job_id = nil, job_name = nil)
      start_sync_time = DbsaleStockCategory.maximum(:last_upd_date)
  
      db_sale_quey_count    = 0
      smart_dc_insert_count = 0
      query = DbsaleStockCategory.all
      event_start_date = DateTime.now
      error = nil
  
      begin
        query.find_in_batches(batch_size: 3000).with_index do |stock_category, batch|
          item_categories = []
          stock_category.each do |category|
            db_sale_quey_count = db_sale_quey_count + 1
  
              item_category = ItemCategory.new(
              item_category_code: category.category_code,
              alternate_name:     category.alternate_name,
              item_category_name: category.description,
              is_active:          category.status == 'A'
            )
            item_categories << item_category
          end
  
          ItemCategory.import(
            item_categories,
            on_duplicate_key_update: ItemCategory.column_names - ['id','item_category_code'],
            validate: false,
            batch_size: 300,
          )
  
          smart_dc_insert_count = smart_dc_insert_count + item_categories.size
        end
      rescue Exception => exception
        error = exception.message
      end
  
    #   ItemCategory.last_synced_at = start_sync_time
      event_end_date = DateTime.now
  
      ItemCategory.log_message(
        job_id,
        job_name,
        DbsaleStockCategory.event_table_name,
        db_sale_quey_count,
        ItemCategory.event_table_name,
        smart_dc_insert_count,
        query,
        event_start_date,
        event_end_date,
        true,
        error
      )
    end
  end
  
