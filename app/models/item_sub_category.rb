# == Schema Information
#
# Table name: item_sub_categories
#
#  id                     :bigint           not null, primary key
#  is_active              :boolean          not null
#  item_sub_category_code :string(10)       not null
#  item_sub_category_name :string(50)       not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  item_category_id       :integer          not null
#
# Indexes
#
#  idx_item_cat_on_item_cat_id_and_item_sub_cat_code    (item_category_id,item_sub_category_code) UNIQUE
#  index_item_sub_categories_on_item_sub_category_code  (item_sub_category_code)
#

class ItemSubCategory < ActiveRecord::Base
  include SyncableModel

  belongs_to :item_category
  has_many :trays, through: :item_category

  def self.map_data(job_id = nil, job_name = nil)
    start_sync_time = DbsaleStockSubCategory.maximum(:last_upd_date)

    db_sale_quey_count    = 0
    smart_dc_insert_count = 0
    event_start_date = DateTime.now
    error = nil
    query = DbsaleStockSubCategory.joins("
      INNER JOIN STOCK_CATEGORY ON STOCK_SUB_CATEGORY.CATEGORY_CODE = STOCK_CATEGORY.CATEGORY_CODE")

    unique_keys = ['id', 'item_category_id', 'item_sub_category_code']
    begin
      query.find_in_batches(batch_size: 3000).with_index do |sub_categorys, batch|
        item_categories = ItemCategory.where(
          item_category_code: sub_categorys.map(&:category_code).uniq
        )
        item_category_hash = ItemSubCategory.create_hash(item_categories, "item_category_code")

        item_sub_categories = []

        sub_categorys.each do |sub_cate|
          db_sale_quey_count = db_sale_quey_count + 1

          item_category_id = item_category_hash[sub_cate.category_code]
          next if item_category_id.nil?

          item_sub_category = ItemSubCategory.new(
            item_category_id:           item_category_id,
            item_sub_category_code:     sub_cate.sub_category_code,
            item_sub_category_name:     sub_cate.description,
            is_active:                  sub_cate.status == 'A'
          )
          item_sub_categories << item_sub_category
        end

        ItemSubCategory.import(
          item_sub_categories,
          on_duplicate_key_update: ItemSubCategory.column_names - unique_keys,
          validate: false,
          batch_size: 300,
        )

        smart_dc_insert_count = smart_dc_insert_count + item_sub_categories.size
      end
    rescue Exception => exception
      error = exception.message
    end

    # ItemSubCategory.last_synced_at = start_sync_time
    event_end_date = DateTime.now

    ItemSubCategory.log_message(
      job_id,
      job_name,
      DbsaleStockSubCategory.event_table_name,
      db_sale_quey_count,
      ItemSubCategory.event_table_name,
      smart_dc_insert_count,
      query,
      event_start_date,
      event_end_date,
      true,
      error
    )
  end
end
