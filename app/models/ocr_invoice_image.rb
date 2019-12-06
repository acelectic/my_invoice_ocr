# == Schema Information
#
# Table name: ocr_invoice_images
#
#  id             :bigint           not null, primary key
#  full_name      :string(255)      not null
#  image_name     :string(255)      not null
#  ocr_date       :date             not null
#  page           :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ocr_invoice_id :integer
#
# Indexes
#
#  index_ocr_invoice_images_unique  (ocr_invoice_id,ocr_date,image_name,page) UNIQUE
#

class OcrInvoiceImage < ApplicationRecord
    include SyncableModel

    belongs_to :ocr_invoice

    validates :image_name,     presence: true
    validates_uniqueness_of :ocr_invoice_id, scope: [:ocr_date, :image_name, :page]

    def self.get_hash(params_ocr_date)
        ocr_invoice_images = where(ocr_date: params_ocr_date)
        create_hash(ocr_invoice_images , ["ocr_invoice_id", "ocr_date", "image_name", "page"], "class")
    end

    def self.incomplete(start_date)
        invoice_ids = OcrInvoice.incomplete(start_date).pluck(:id)
        perform_incomplete(invoice_ids)
    end

    def self.incomplete_history(start_date, end_date)
        invoice_ids = OcrInvoice.incomplete_history(start_date, end_date).pluck(:id)
        perform_incomplete(invoice_ids)
    end

    def self.unverifiable(start_date)
        condition = "ocr_invoice_id is null and ocr_date = '#{start_date}'"
        perform_unverifiable(condition)
    end

    def self.unverifiable_history(start_date, end_date = nil)
        condition = "ocr_invoice_id is null and "

        if (start_date.nil? and end_date.nil?) or (!start_date.nil? and !end_date.nil?)
            condition += "ocr_date between '#{start_date}' and '#{end_date}'"
        elsif end_date.nil? 
            condition += "ocr_date >= '#{start_date}'"
        elsif start_date.nil?
            condition += "ocr_date <= '#{end_date}'"
        end

        perform_unverifiable(condition)
    end

    def self.perform_incomplete(invoice_ids)
        where(ocr_invoice_id: invoice_ids)
    end

    def self.perform_unverifiable(condition)
        where(condition)
    end

    def self.import_data(datas)
        transaction do
            import!(
                datas,
                on_duplicate_key_update:  column_names - ["id", "ocr_invoice_id", "ocr_date", "image_name", "page"],
                validate: true,
                batch_size: 1000
            )
        end
    end
end
