class DashboardAction::Query::SuspectHistory < DashboardAction::Query::Suspect

    attr_reader :start_date, :end_date, :distribution_center_id, :dc_route_code, :invoice_date, :status, :ocr_status

    def initialize(option = {})
        @start_date             = (option[:start_date].nil? or option[:start_date] == "วันที่เริ่มต้น") ? nil : option[:start_date].to_date
        @end_date               = (option[:end_date].nil?   or option[:end_date]   == "วันที่สิ้นสุด")  ? nil : option[:end_date].to_date
        @distribution_center_id = option[:distribution_center_id]
        @dc_route_code          = (option[:dc_route_code] == "เลือกหน่วยขาย(ทั้งหมด)" || option[:dc_route_code].nil?) ? nil : option[:dc_route_code]
        @invoice_date           = (option[:invoice_date] == "วันที่ใบกำกับภาษี(ทั้งหมด)" || option[:invoice_date].nil?) ? nil : option[:invoice_date]
        @status                 = option[:status].nil? ? "0" : option[:status]
        @ocr_status             = option[:ocr_status].nil? ? "0" : option[:ocr_status]
    end

    def get_data       
        tr_invoices         = TrInvoice.dashboard_history(distribution_center_id, start_date, end_date)
        tr_suspect_invoices = TrInvoice.dashboard_suspect_history_with_filter(distribution_center_id, start_date, end_date, dc_route_code, invoice_date)
        
        response = { start_date: start_date, end_date: end_date}.merge(suspect_invoices_header(tr_invoices, tr_suspect_invoices))
        return response
    end
    
    def suspect_invoices_header(tr_invoices, tr_suspect_invoices)
        distribution_center = tr_invoices.first.ms_invoice.distribution_center

		{
            start_date:                   start_date,
            end_date:                     end_date,
			distribution_center_id:       distribution_center.id,
			distribution_center_code:     distribution_center.distribution_center_code,
			distribution_center_name:     distribution_center.distribution_center_name,
			total_verified_invoice_qty:   tr_invoices.size,
			correct_verified_invoice_qty: TrInvoice.count_result_true(tr_invoices),
			suspect_verified_invoice_qty: TrInvoice.count_result_false(tr_invoices),
            suspect_invoices:             suspect_invoices(tr_suspect_invoices),
            dc_routes_code:               tr_suspect_invoices.pluck(:dc_route_code).unshift("เลือกหน่วยขาย(ทั้งหมด)").uniq,
            invoice_date:                 tr_suspect_invoices.pluck(:invoice_date).unshift("วันที่ใบกำกับภาษี(ทั้งหมด)").uniq,
            status:                       ["สถานะการตรวจ(ทั้งหมด)", "ตรวจแล้ว", "ยังไม่ตรวจ"],
            ocr_status:                   ["ผลลัพธ์ OCR(ทั้งหมด)", "ไม่ผิด", "ผิดจริง"]
		}
	end
end