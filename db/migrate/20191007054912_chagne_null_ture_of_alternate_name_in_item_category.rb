class ChagneNullTureOfAlternateNameInItemCategory < ActiveRecord::Migration[6.0]
  
  def up
    change_column_null(:item_categories, :alternate_name, true)
  end

  def down
    change_column_null(:item_categories, :alternate_name, false)
  end
end
