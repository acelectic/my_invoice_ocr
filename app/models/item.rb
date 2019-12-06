# == Schema Information
#
# Table name: items
#
#  id                   :bigint           not null, primary key
#  description          :string(200)
#  is_active            :boolean          default(TRUE), not null
#  is_boi               :boolean          default(TRUE), not null
#  item_code            :string(40)       not null
#  item_eng_name        :string(100)
#  item_thai_name       :string(100)      not null
#  item_type            :string(1)        not null
#  remain_code          :string(40)
#  short_name           :string(100)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  item_sub_category_id :integer
#  unit_of_measure_id   :integer          not null
#
# Indexes
#
#  index_items_on_item_code  (item_code) UNIQUE
#

class Item < ActiveRecord::Base
    include SyncableModel
  
    belongs_to :unit_of_measure, :class_name => "ItemUnitOfMeasure", :foreign_key => 'unit_of_measure_id'
    belongs_to :item_sub_category
    has_one :item_category, through: :item_sub_category
    has_many :ocr_invoice_items
  
    default_scope {
      joins(:item_category)
      .order("item_categories.item_category_code, item_sub_categories.item_sub_category_code, item_code")
    }

    def self.get_hash
      create_hash(all , "item_code", "class")
    end
  
    def self.map_data(job_id = nil, job_name = nil)
  
      db_sale_quey_count    = 0
      smart_dc_insert_count = 0
      event_start_date = DateTime.now
      error = nil
      query = DbsaleItem.select("ITEMS.*").where("ITEM_CODE NOT IN (
          SELECT
            ITEM_CODE
          FROM
            ITEMS
          WHERE
            ((CATEGORY_CODE = '9999'
            AND SUB_CATEGORY_CODE BETWEEN '999901' AND '999905')
            OR NVL(tray_flag, 'N') = 'Y'))")
        .where("ITEM_UM IS NOT NULL")
        .joins("INNER JOIN STOCK_CATEGORY ON STOCK_CATEGORY.CATEGORY_CODE = ITEMS.CATEGORY_CODE")
        .joins("INNER JOIN STOCK_SUB_CATEGORY ON STOCK_SUB_CATEGORY.CATEGORY_CODE = ITEMS.CATEGORY_CODE").distinct
  
  
      begin
        query.find_in_batches(batch_size: 3000) do |dbsale_items|
          sub_category_ids = {}
          um_hash = Item.create_hash(ItemUnitOfMeasure.all, "item_um_code")
          ItemSubCategory.all.each do |sub_category|
            sub_category_ids[sub_category.item_sub_category_code] = sub_category.id
          end
          items = []
          dbsale_items.each do |dbsale_item|
            db_sale_quey_count = db_sale_quey_count + 1
  
            unit_of_measure_id = um_hash[dbsale_item.item_um]
            next if unit_of_measure_id.nil?
            items << Item.new(
              item_code:            dbsale_item.item_code,
              short_name:           dbsale_item.short_name,
              item_thai_name:       dbsale_item.item_name_thai,
              item_eng_name:        dbsale_item.item_name_eng,
              description:          dbsale_item.detailed_description,
              item_type:            dbsale_item.record_type,
              is_active:            dbsale_item.status == 'A',
              remain_code:          dbsale_item.remain_item_code,
              is_boi:               dbsale_item.boi_flag == 'Y',
              item_sub_category_id: sub_category_ids["#{dbsale_item.sub_category_code}"],
              unit_of_measure_id:   unit_of_measure_id
            )
          end
          Item.import(
            items,
            on_duplicate_key_update: Item.column_names - ['id', 'item_code'],
            validate: false,
            batch_size: 300
          )
  
          smart_dc_insert_count = smart_dc_insert_count + items.size
        end
      rescue Exception => exception
        error = exception.message
      end
    end
  
  
end
  
