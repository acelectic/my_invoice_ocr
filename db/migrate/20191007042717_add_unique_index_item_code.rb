class AddUniqueIndexItemCode < ActiveRecord::Migration[6.0]
  def up
    add_index :items, [:item_code], name: "index_items_on_item_code", unique: true
  end

  def down
    remove_index  :items, name: "index_items_on_item_code"
  end
end
