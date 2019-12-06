class AddIndexInItemCategory < ActiveRecord::Migration[6.0]
  def up
    add_index :item_categories, [:item_category_code], name: "index_item_categories_on_item_cat_code", unique: true
  end

  def down
    remove_index :item_categories, name: "index_item_categories_on_item_cat_code"
  end
end
