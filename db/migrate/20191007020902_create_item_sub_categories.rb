class CreateItemSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :item_sub_categories do |t|

      t.integer :item_category_id,       null: false
      t.string  :item_sub_category_code, limit: 10, null: false
      t.string  :item_sub_category_name, limit: 50, null: false
      t.boolean :is_active,              null: false, defualt: true
      t.timestamps

    end
  end
end
