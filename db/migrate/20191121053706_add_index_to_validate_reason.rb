class AddIndexToValidateReason < ActiveRecord::Migration[6.0]
    def up
      add_index :validate_reasons, [:reason_code, :reason_type], name: "index_reason_code_and_type_validate_reasons_unique", unique: true
      add_index :validate_reasons, :desc, name: "index_desc_validate_reasons_unique", unique: true
    end
  
    def down
      remove_index :validate_reasons, name: "index_reason_code_and_type_validate_reasons_unique"
      remove_index :validate_reasons, name: "index_desc_validate_reasons_unique"
    end
end
