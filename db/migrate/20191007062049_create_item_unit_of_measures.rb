class CreateItemUnitOfMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :item_unit_of_measures do |t|
      t.string :item_um_code,  null: false,   limit:  4
      t.string :item_um_name,  null: false,   limit:  255
      t.string :status, limit:  1
      t.timestamps
    end
  end
end
