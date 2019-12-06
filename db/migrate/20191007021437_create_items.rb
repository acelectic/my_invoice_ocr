class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|

      t.string  :item_code,             limit: 40,    null: false
      t.string  :short_name,            limit: 100
      t.string  :item_thai_name,        limit: 100,   null: false
      t.string  :item_eng_name,         limit: 100
      t.string  :description,           limit: 200
      t.string  :item_type,             limit: 1,     null: false
      t.boolean :is_active,             null: false,  default: true
      t.string  :remain_code,           limit: 40
      t.boolean :is_boi,                null: false,  default: true
      t.integer :item_sub_category_id
      t.integer :unit_of_measure_id,    null: false
      t.timestamps
    end
  end
end
