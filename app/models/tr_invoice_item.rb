# == Schema Information
#
# Table name: tr_invoice_items
#
#  id                  :bigint           not null, primary key
#  invoice_sequence    :integer          not null
#  ocr_item_result     :boolean          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  ms_invoice_item_id  :integer          not null
#  ocr_invoice_item_id :integer
#  tr_invoice_id       :integer          not null
#
# Indexes
#
#  index_tr_invoice_items_unique  (invoice_sequence,ms_invoice_item_id,tr_invoice_id) UNIQUE
#

class TrInvoiceItem < ApplicationRecord
    belongs_to :tr_invoice
    belongs_to :ms_invoice_item
    belongs_to :ocr_invoice_item, optional: true

    validates :invoice_sequence,   presence: true
    validates :ms_invoice_item_id, presence: true
    validates_inclusion_of :ocr_item_result, in: [true, false]
    validates_uniqueness_of :invoice_sequence, scope: [:ms_invoice_item_id, :tr_invoice_id]

    delegate :value,      to: :ms_invoice_item
    delegate :item_code,  to: :ms_invoice_item
    delegate :short_name, to: :ms_invoice_item

    def self.import_data(datas)
        transaction do
            import!(
                datas,
                on_duplicate_key_update:  column_names - ["id", "invoice_sequence", "ms_invoice_item_id", "tr_invoice_id"],
                validate: true,
                batch_size: 1000
            )
        end
    end
end
