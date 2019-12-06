class AddIndexUnitOfMeasuresItemCode < ActiveRecord::Migration[6.0]
  def up
    add_index :item_unit_of_measures, [:item_um_code], name: "index_item_unit_of_measures_on_item_um_code", unique: true
  end

  def down
    remove_index  :item_unit_of_measures, name: "index_item_unit_of_measures_on_item_um_code"
  end
end
