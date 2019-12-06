# == Schema Information
#
# Table name: item_unit_of_measures
#
#  id           :bigint           not null, primary key
#  item_um_code :string(4)        not null
#  item_um_name :string(255)      not null
#  status       :string(1)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_item_unit_of_measures_on_item_um_code  (item_um_code) UNIQUE
#

class ItemUnitOfMeasure < ActiveRecord::Base
  include SyncableModel

  has_many :trays

  def self.map_data(job_id = nil, job_name = nil)
    start_sync_time = DbsaleUnitOfMeasure.maximum(:last_upd_date)

    db_sale_quey_count    = 0
    smart_dc_insert_count = 0
    event_start_date = DateTime.now
    error = nil
    query = DbsaleUnitOfMeasure.all

    begin
      query.find_in_batches(batch_size: 3000).with_index do |unit_of_measure, batch|
        item_units = []
        unit_of_measure.each do |unit|
          db_sale_quey_count = db_sale_quey_count + 1
          item_unit = ItemUnitOfMeasure.new(
            item_um_code:      unit.um_code,
            item_um_name:      unit.description,
            status:            unit.status
          )
          item_units << item_unit
        end

        ItemUnitOfMeasure.import(
          item_units,
          on_duplicate_key_update: ItemUnitOfMeasure.column_names - ['id','item_um_code'],
          validate: false,
          batch_size: 300,
        )

        smart_dc_insert_count = smart_dc_insert_count + item_units.size
      end
    rescue Exception => exception
      error = exception.message
    end

    # ItemUnitOfMeasure.last_synced_at = start_sync_time
    event_end_date = DateTime.now

    ItemUnitOfMeasure.log_message(
      job_id,
      job_name,
      DbsaleUnitOfMeasure.event_table_name,
      db_sale_quey_count,
      ItemUnitOfMeasure.event_table_name,
      smart_dc_insert_count,
      query,
      event_start_date,
      event_end_date,
      true,
      error
    )
  end
end
