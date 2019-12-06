# == Schema Information
#
# Table name: ms_invoice_items
#
#  id            :bigint           not null, primary key
#  seq_no        :integer
#  value         :float(24)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  invoice_id    :bigint
#  item_id       :integer
#  ms_invoice_id :bigint
#
# Indexes
#
#  index_ms_invoice_items_unique  (ms_invoice_id,item_id) UNIQUE
#

class MsInvoiceItem < ActiveRecord::Base
  include SyncableModel

  belongs_to :item
  has_one :item_sub_category, through: :item
  has_one :item_category,     through: :item_sub_category

  default_scope {
    joins(:item_category)
    .order("item_categories.item_category_code, item_sub_categories.item_sub_category_code, item_code")
  }

  delegate :item_code,  to: :item
  delegate :short_name, to: :item

  def self.map_data(job_id = nil, job_name = nil)
    db_sale_quey_count    = 0
    smart_dc_insert_count = 0
    event_start_date      = DateTime.now
    ms_invoice_hash       = create_hash(MsInvoice.all, "invoice_id", "class")
    item_hash             = create_hash(Item.all,      "item_code",  "class")
    error = nil
      
    store_id_query = DbsaleInvoice.select("*").from(
      "(SELECT
        count(*) AS total_count,
        INVOICES.STORE_ID
      FROM
        INVOICE_ITEMS
      JOIN INVOICES ON
        INVOICES.INVOICE_ID = INVOICE_ITEMS.INVOICE_ID
      GROUP BY
        INVOICES.STORE_ID)"
    )
  
  event_start_date = DateTime.now
  begin
    store_id_query.each do |r|
      result                 = map_data_by_store_id(r[:store_id], r[:total_count], item_hash, ms_invoice_hash)
      db_sale_quey_count    += result[:db_sale_quey_count]
      smart_dc_insert_count += result[:smart_dc_insert_count]
    end
  rescue Exception => exception
    error = exception.message
    puts exception.message
  end
  event_end_date = DateTime.now

  
  end

  def self.map_data_by_store_id(store_id, total_count, item_hash, ms_invoice_hash)
      db_sale_quey_count    = 0
      smart_dc_insert_count = 0
      batch_size            = 30000

      total_count = total_count - batch_size if total_count > batch_size
      (0..total_count).step(batch_size) do |offset|
        records = DbsaleInvoiceItem.select("*").from(
          "(SELECT * FROM (
          SELECT INV_I.*, ROWNUM AS RN
          FROM (
              SELECT
                *
              FROM
                INVOICE_ITEMS
              JOIN INVOICES ON INVOICES.INVOICE_ID = INVOICE_ITEMS.INVOICE_ID
              WHERE
                INVOICES.COST_CENTER_CODE = 110
                AND INVOICES.STORE_ID = '#{store_id}'
                AND INVOICE_ITEMS.ITEM_CODE NOT IN ('99')
              ) INV_I
            WHERE ROWNUM <= #{batch_size + offset}
          ) SUB
          WHERE SUB.RN > #{offset})"
        )
        new_ms_invoice_items = []
        records.each do |dbsale_invoice_item|
          db_sale_quey_count += 1

          ms_invoice = ms_invoice_hash[dbsale_invoice_item.invoice_id.to_s]
          item       = item_hash[dbsale_invoice_item.item_code]

          next if ms_invoice.nil?
          next if item.nil?

          ms_invoice_id = ms_invoice.id
          invoice_id    = dbsale_invoice_item.invoice_id
          item_id       = item.id
          value         = dbsale_invoice_item.value

          new_ms_invoice_items << MsInvoiceItem.new(
            ms_invoice_id: ms_invoice_id,
            invoice_id:    invoice_id,
            item_id:       item_id,
            value:         value
          )
          # puts new_ms_invoice_items
        end

        import(
          new_ms_invoice_items,
          on_duplicate_key_update: MsInvoiceItem.column_names - ['id', 'ms_invoice_id',  'item_id'],
          validate: false,
          batch_size: 3000,
        )
        smart_dc_insert_count += new_ms_invoice_items.size
      end
      {
        db_sale_quey_count: db_sale_quey_count,
        smart_dc_insert_count: smart_dc_insert_count
      }
  end

end
