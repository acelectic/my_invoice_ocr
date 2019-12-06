# == Schema Information
#
# Table name: validate_reasons
#
#  id          :bigint           not null, primary key
#  creator     :string(6)        not null
#  desc        :string(255)      not null
#  is_active   :boolean          default(TRUE), not null
#  reason_code :string(4)        not null
#  reason_type :boolean          not null
#  updator     :string(6)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_desc_validate_reasons_unique                  (desc) UNIQUE
#  index_reason_code_and_type_validate_reasons_unique  (reason_code,reason_type) UNIQUE
#
class ValidateReason < ApplicationRecord

    has_many :tr_invoices
    validates :reason_code,  presence: true 
    validates :desc, presence: true

    def self.add_reason(reason)
        import(
          [reason],
          on_duplicate_key_update: ValidateReason.column_names - ['id', 'reason_code','creator', 'reason_type', 'created_at'],
          validate: false,
          batch_size: 1000,
        )
    end

    def self.find_by_desc(desc)
        where(desc: desc)
    end

    def self.find_id_by_code(reason_code)
        all.select(:id, :reason_code).where(reason_code: reason_code)
    end

    def self.perform_validate_reasons
        all
    end

    def self.perform_valid_reasons
        where("reason_type = true")
    end

    def self.perform_invalid_reasons
        where("reason_type = false")
    end

    def self.perform_reasons
        all.includes(:tr_invoices)
    end

end
