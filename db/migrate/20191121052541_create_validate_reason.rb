class CreateValidateReason < ActiveRecord::Migration[6.0]
  def change
    create_table :validate_reasons do |t|
      
      t.string  :reason_code, limit: 4, null: false
      t.string  :desc,        null: false
      t.boolean :is_active,   null: false,  default: true
      t.string  :creator,     limit: 6, null: false
      t.string  :updator,     limit: 6, null: false
      t.boolean :reason_type,  null:false
      t.timestamps null: false
    end
  end
end
