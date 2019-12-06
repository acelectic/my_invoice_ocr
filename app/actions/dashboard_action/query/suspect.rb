class DashboardAction::Query::Suspect < BaseAction

    attr_reader :date, :distribution_center_id, :dc_route_code, :invoice_date, :status, :ocr_status, :start_date, :end_date, :is_history

    def initialize(option = {})
        @date                   = option[:date] || DateTime.now.to_date
        @distribution_center_id = option[:distribution_center_id]
        @dc_route_code          = (option[:dc_route_code] == "เลือกหน่วยขาย(ทั้งหมด)" || option[:dc_route_code].nil?) ? nil : option[:dc_route_code]
        @invoice_date           = (option[:invoice_date] == "วันที่ใบกำกับภาษี(ทั้งหมด)" || option[:invoice_date].nil?) ? nil : option[:invoice_date]
        @status                 = option[:status].nil? ? "0" : option[:status]
        @ocr_status             = option[:ocr_status].nil? ? "0" : option[:ocr_status]
    end

    def get_data       
        tr_invoices         = TrInvoice.dashboard(distribution_center_id, date)
        tr_suspect_invoices = TrInvoice.dashboard_suspect_with_filter(distribution_center_id, date, dc_route_code, invoice_date)
        
        response = { ocr_date: date }.merge(suspect_invoices_header(tr_invoices, tr_suspect_invoices))
        return response
    end
    
    def suspect_invoices_header(tr_invoices, tr_suspect_invoices)
        distribution_center = tr_invoices.first.ms_invoice.distribution_center

	    {
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

    def suspect_invoices(tr_invoices)
        response_tr_invoices = []

        tr_invoices.each do |tr_invoice|
            reason_type = tr_invoice.validate_reason_id.nil? ? nil : tr_invoice.validate_reason.reason_type

            response_tr_invoice = {
                tr_invoice_id:       tr_invoice.id,
                dc_route_code:       tr_invoice.dc_route_code,
                vat_no:              tr_invoice.vat_invoice_number,
                customer_store_code: tr_invoice.customer_store_code,
                customer_store_name: tr_invoice.display_name,
                customer_store_type: tr_invoice.customer_store_type_name,
                invoice_date:	     tr_invoice.invoice_date,
                reason_type:	     reason_type,
                user_id:			 "",
                status:				 reason_type.nil? ? "ยังไม่ตรวจ" : "ตรวจแล้ว",
                remark:				 "",
                tr_invoice_items:    tr_invoice.tr_invoice_items,
                images:              tr_invoice.ocr_invoice_images
            } 

            if is_reponse_status(reason_type) && is_response_ocr_status(reason_type)
                response_tr_invoices << response_tr_invoice
            end
        end

        return response_tr_invoices
    end
    
    def is_reponse_status(reason_type)
		return (status == "0") || (status == "1" && reason_type != nil) || (status == "2" && reason_type == nil) 
    end
    
    def is_response_ocr_status(reason_type)
        return (ocr_status == "0") || (ocr_status == "1" && reason_type == true) || (ocr_status == "2" && reason_type == false) 
    end
end