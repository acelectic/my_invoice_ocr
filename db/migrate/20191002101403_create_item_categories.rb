class CreateItemCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :item_categories do |t|
      
      t.string  :item_category_code, null: false, limit: 10
      t.string  :item_category_name, null: false, limit: 50
      t.boolean :is_active,          null: false, default: true
      t.string  :alternate_name,     null: false, limit: 20
      t.timestamps
      
    end
    
  end
end
