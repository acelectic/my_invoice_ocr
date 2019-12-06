# == Schema Information
#
# Table name: ocr_invoice_items
#
#  id               :bigint           not null, primary key
#  invoice_sequence :string(255)
#  page             :float(24)
#  price            :float(24)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  item_id          :integer          not null
#  ocr_invoice_id   :integer
#
# Indexes
#
#  index_ocr_invoice_items_unique  (ocr_invoice_id,item_id) UNIQUE
#

class OcrInvoiceItem < ApplicationRecord
    include SyncableModel

    belongs_to :item
    belongs_to :ocr_invoice
    belongs_to :item

    has_one    :item_sub_category, through: :item
    has_one    :item_category,     through: :item_sub_category

    has_many   :tr_invoice_items

    default_scope {
        joins(:item_category)
        .order("item_categories.item_category_code, item_sub_categories.item_sub_category_code, item_code")
    }

    validates :invoice_sequence, presence: true
    validates :item_id,          presence: true
    validates :page,             presence: true
    validates :price,            presence: true
    validates_uniqueness_of :ocr_invoice_id, scope: [:item_id]

    def self.get_hash(params_ocr_date)
        ocr_invoice_items = joins(:ocr_invoice).where('ocr_invoices.ocr_date = ?', params_ocr_date)
        create_hash(ocr_invoice_items , ["ocr_invoice_id", "item_id"], "class")
    end

    def self.import_data(datas)
        transaction do
            import!(
                datas,
                on_duplicate_key_update: column_names - ["id", "ocr_invoice_id", "item_id"],
                validate: true,
                batch_size: 1000
            )
        end
    end
end
