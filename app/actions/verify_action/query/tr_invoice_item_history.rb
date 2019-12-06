class VerifyAction::Query::TrInvoiceItemHistory < VerifyAction::Query::TrInvoiceItem

    attr_reader :distribution_center_id, :date, :page, :per, :page_size, :dc_route_code, :invoice_date, :status, :ocr_status, :start_date, :end_date, :is_history

    def initialize(option = {})
        @page                   = option[:page].to_i
        @per                    = option[:per]
        @start_date             = (option[:start_date].nil? or option[:start_date] == "วันที่เริ่มต้น") ? nil : option[:start_date].to_date
        @end_date               = (option[:end_date].nil?   or option[:end_date]   == "วันที่สิ้นสุด")  ? nil : option[:end_date].to_date
        @is_history             = option[:is_history]
        @distribution_center_id = option[:distribution_center_id]
        @dc_route_code          = (option[:dc_route_code] == "เลือกหน่วยขาย(ทั้งหมด)" || option[:dc_route_code].nil?) ? nil : option[:dc_route_code]
        @invoice_date           = (option[:invoice_date] == "วันที่ใบกำกับภาษี(ทั้งหมด)" || option[:invoice_date].nil?) ? nil : option[:invoice_date]
        @status                 = option[:status].nil? ? "0" : option[:status]
        @ocr_status             = option[:ocr_status].nil? ? "0" : option[:ocr_status]
        @page_size              = 5
    end

    def get_tr_invoices
        TrInvoice.dashboard_suspect_with_filter(distribution_center_id, date, dc_route_code, invoice_date)
    end
end