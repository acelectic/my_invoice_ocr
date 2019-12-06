# == Schema Information
#
# Table name: ocr_invoices
#
#  id                :bigint           not null, primary key
#  is_compared       :boolean          default(FALSE), not null
#  net_price         :float(24)
#  ocr_date          :date             not null
#  sequence          :integer
#  status            :string(255)
#  total_page        :float(24)
#  vat_no            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  customer_store_id :integer          not null
#
# Indexes
#
#  index_ocr_invoices_ocr_date  (ocr_date)
#  index_ocr_invoices_unique    (ocr_date,customer_store_id,vat_no) UNIQUE
#

class OcrInvoice < ApplicationRecord
    include SyncableModel

    has_many :ocr_invoice_items
    has_many :ocr_invoice_images

    belongs_to :customer_store

    validates :customer_store_id,   presence: true
    validates :sequence,            presence: true
    validates :status,              presence: true
    validates :total_page,          presence: true
    validates :vat_no,              presence: true
    validates_uniqueness_of :ocr_date, scope: [:customer_store_id, :vat_no]

    def self.get_hash(params_ocr_date)
        ocr_invoices = where(ocr_date: params_ocr_date)
        create_hash(ocr_invoices , ["ocr_date", "customer_store_id", "vat_no"], "class")
    end

    def self.not_yet_compared(date)
        where(ocr_date: date, is_compared: false).includes(:ocr_invoice_images).select { |invoice| invoice.total_page == invoice.ocr_invoice_images.size }
    end

    def self.incomplete_count(start_date)
        incomplete(start_date).size
    end
    
    def self.incomplete_history_count(start_date, end_date)
        incomplete_history(start_date, end_date).size
    end

    def self.incomplete(start_date)
        condition = "ocr_date = '#{start_date}' and is_compared = false"
        perform_incomplete(condition)
    end

    def self.incomplete_history(start_date, end_date = nil)
        condition = "is_compared = false and "

        if (start_date.nil? and end_date.nil?) or (!start_date.nil? and !end_date.nil?)
            condition += "ocr_date between '#{start_date}' and '#{end_date}'"
        elsif end_date.nil? 
            condition += "ocr_date >= '#{start_date}'"
        elsif start_date.nil?
            condition += "ocr_date <= '#{end_date}'"
        end
        
        perform_incomplete(condition)
    end

    def self.perform_incomplete(condition)
        where(condition).includes(:ocr_invoice_images).select { |invoice| invoice.total_page != invoice.ocr_invoice_images.size }
    end

    def self.import_data(datas)
        transaction do
            import!(
                datas,
                on_duplicate_key_update:  column_names - ["id", "ocr_date", "customer_store_id", "vat_no"],
                validate: true,
                batch_size: 1000
            )
        end
    end
end
