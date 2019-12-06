# == Schema Information
#
# Table name: tr_invoices
#
#  id                 :bigint           not null, primary key
#  is_compared        :boolean          default(FALSE), not null
#  ocr_date           :date             not null
#  ocr_result         :boolean          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  ms_invoice_id      :integer          not null
#  ocr_invoice_id     :integer          not null
#  validate_reason_id :integer
#
# Indexes
#
#  index_customers_unique                     (ocr_date,ms_invoice_id,ocr_invoice_id) UNIQUE
#  index_tr_invoices_ocr_date                 (ocr_date)
#  index_tr_invoices_ocr_date_and_ocr_result  (ocr_date,ocr_result)
#

class TrInvoice < ApplicationRecord
    include SyncableModel
    
    belongs_to :ms_invoice
    belongs_to :ocr_invoice
    belongs_to :validate_reason

    has_many :tr_invoice_items
    has_many :ocr_invoice_images, through: :ocr_invoice

    validates :ms_invoice_id,  presence: true 
    validates :ocr_invoice_id, presence: true
    validates_inclusion_of :ocr_result, in: [true, false]
    validates_uniqueness_of :ocr_date, scope: [:ms_invoice_id, :ocr_invoice_id]
 
    delegate :display_name,             to: :ms_invoice
    delegate :invoice_date,             to: :ms_invoice
    delegate :dc_route_code,            to: :ms_invoice
    delegate :vat_invoice_number,       to: :ms_invoice
    delegate :customer_store_code,      to: :ms_invoice
    delegate :customer_store_type_name, to: :ms_invoice

    def self.dashboard(id, date)
        conditions = "distribution_centers.id = #{id} and tr_invoices.ocr_date = '#{date.to_date}'"
        perform_dashboard(conditions)
    end

    def self.dashboard_history(id, start_date, end_date)
        conditions =  "distribution_centers.id = #{id} and "

        if (start_date.nil? and end_date.nil?) or (!start_date.nil? and !end_date.nil?)
            conditions += "ocr_date between '#{start_date}' and '#{end_date}'"
        elsif end_date.nil? 
            conditions += "ocr_date >= '#{start_date}'"
        elsif start_date.nil?
            conditions += "ocr_date <= '#{end_date}'"
        end

        perform_dashboard(conditions)
    end

    def self.dashboard_suspect(id, date)
        condition = { ms_invoices: { distribution_centers: { id: id }}, tr_invoices: {  ocr_date: date,  ocr_result: false } }
        perform_dashboard_suspect(condition)
    end

    def self.dashboard_suspect_history(id, start_date, end_date)
        conditions = "distribution_centers.id = #{id} and tr_invoices.ocr_result = false and "

        if (start_date.nil? and end_date.nil?) or (!start_date.nil? and !end_date.nil?)
            conditions += "ocr_date between '#{start_date}' and '#{end_date}'"
        elsif end_date.nil? 
            conditions += "ocr_date >= '#{start_date}'"
        elsif start_date.nil?
            conditions += "ocr_date <= '#{end_date}'"
        end

        perform_dashboard_suspect(conditions)
    end

    def self.dashboard_suspect_with_filter(id, date, dc_route_code, invoice_date)
        conditions = { ms_invoices: { distribution_centers: { id: id }, dc_routes: { dc_route_code: dc_route_code }.compact, invoice_date: invoice_date }.reject {|_,v| v.blank?},   tr_invoices: {  ocr_date: date,  ocr_result: false }.compact }.compact
        perform_dashboard_suspect_with_filter(conditions)
    end

    def self.dashboard_suspect_history_with_filter(id, start_date, end_date, dc_route_code, invoice_date)
        conditions = ""
        
        if (dc_route_code.nil? and invoice_date.nil?)
            conditions += "distribution_centers.id = #{id} and tr_invoices.ocr_result = false and "
        elsif invoice_date.nil?
            conditions += "distribution_centers.id = #{id} and dc_routes.dc_route_code = '#{dc_route_code}' and tr_invoices.ocr_result = false and "
        elsif dc_route_code.nil?
            conditions += "distribution_centers.id = #{id} and invoice_date = '#{invoice_date}' and tr_invoices.ocr_result = false and "
        elsif (!dc_route_code.nil? and !invoice_date.nil?)
            conditions += "distribution_centers.id = #{id} and dc_routes.dc_route_code = '#{dc_route_code}' and invoice_date = '#{invoice_date}' and tr_invoices.ocr_result = false and "
        end
        
        
        if (start_date.nil? and end_date.nil?) or (!start_date.nil? and !end_date.nil?)
            conditions += "tr_invoices.ocr_date between '#{start_date}' and '#{end_date}'"
        elsif end_date.nil? 
            conditions += "tr_invoices.ocr_date >= '#{start_date}'"
        elsif start_date.nil?
            conditions += "tr_invoices.ocr_date <= '#{end_date}'"
        end

        perform_dashboard_suspect_with_filter(conditions)
    end

    def self.search(word)
        all
        .joins(:ocr_invoice)
        .where("ocr_invoices.vat_no LIKE '%#{word}%'")
        .includes(ms_invoice: [ :customer_store, :distribution_center, :dc_route, { customer_store: :customer } ])
    end

    def self.perform_dashboard(conditions)
        all
        .joins(ms_invoice: :distribution_center)
        .where(conditions)
    end

    def self.perform_dashboard_suspect(condition)
        all
        .joins(ms_invoice: [:distribution_center, :dc_route])
        .where(condition)
        .includes(:tr_invoice_items, :ocr_invoice_images, tr_invoice_items: { ms_invoice_item: :item}, ms_invoice: [ :customer_store, :distribution_center, :dc_route, { customer_store: :customer } ])
    end

    def self.perform_dashboard_suspect_with_filter(conditions)
        all
        .joins(ms_invoice: [:distribution_center, :dc_route])
        .where(conditions) 
        .includes(:validate_reason, :tr_invoice_items, :ocr_invoice_images, tr_invoice_items: { ms_invoice_item: :item}, ms_invoice: [ :customer_store, :distribution_center, :dc_route, { customer_store: :customer } ])
    end

    def self.with_date(start_date)
        condition = "ocr_date = '#{start_date}'"
        perform_with_date(condition)
    end

    def self.with_date_range(start_date, end_date = nil)
        condition = ""

        if (start_date.nil? and end_date.nil?) or (!start_date.nil? and !end_date.nil?)
            condition += "ocr_date between '#{start_date}' and '#{end_date}'"
        elsif end_date.nil? 
            condition += "ocr_date >= '#{start_date}'"
        elsif start_date.nil?
            condition += "ocr_date <= '#{end_date}'"
        end

        perform_with_date(condition)
    end
    
    def self.perform_with_date(condition)
        where(condition)
    end

    def self.total_count(date)
        where(ocr_date: date).size
    end

    def self.count_result_true(tr_invoices)
        return 0 if tr_invoices.nil?
        tr_invoices.select { |tr_invoice| tr_invoice.ocr_result == true }.count
    end

    def self.count_result_false(tr_invoices)
        return 0 if tr_invoices.nil?
        tr_invoices.select { |tr_invoice| tr_invoice.ocr_result == false }.count
    end

    def self.status_verify_ocr_result(tr_invoices)
       tr_invoices.select { |tr_invoice| tr_invoice.ocr_result == false && tr_invoice.validate_reason_id == nil}.nil? == true
    end

    def self.get_hash
        tr_invoices = where(is_compared: false)
        create_hash(tr_invoices , ["ocr_date", "ms_invoice_id", "ocr_invoice_id"], "class")
    end

    def self.get_verify_list
        all.select(:validate_reason_id).group(:validate_reason_id)
    end

    def self.import_data(datas)
        transaction do
            import!(
                datas,
                on_duplicate_key_update:  column_names - ["id", "ocr_date", "ms_invoice_id", "ocr_invoice_id"],
                validate: true,
                batch_size: 1000
            )
        end
    end

    def self.get_last_id
        tr_invoice_size = all.size
        return 1 if tr_invoice_size == 0
        return last.id + 1 
    end

    def self.update_reason(option = {})
        temp_tr = find_by(id: option[:tr_invoice_id])
        temp_tr[:validate_reason_id] = option[:validate_reason_id]
    
        import(
          [temp_tr],
          on_duplicate_key_update: ['validate_reason_id'],
          validate: false,
          batch_size: 1000,
        )
    end
end
