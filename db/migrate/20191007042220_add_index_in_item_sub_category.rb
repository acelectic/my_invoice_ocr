class AddIndexInItemSubCategory < ActiveRecord::Migration[6.0]
  def up
    add_index     :item_sub_categories, [:item_category_id, :item_sub_category_code], name: "idx_item_cat_on_item_cat_id_and_item_sub_cat_code", unique: true
    add_index     :item_sub_categories, [:item_sub_category_code], name: "index_item_sub_categories_on_item_sub_category_code"
  end

  def down
    remove_index  :item_sub_categories, name: "idx_item_cat_on_item_cat_id_and_item_sub_cat_code"
    remove_index  :item_sub_categories, name: "index_item_sub_categories_on_item_sub_category_code"

  end
end
