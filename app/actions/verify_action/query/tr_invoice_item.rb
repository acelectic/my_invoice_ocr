class VerifyAction::Query::TrInvoiceItem < BaseAction

    attr_reader :distribution_center_id, :date, :page, :per, :page_size, :dc_route_code, :invoice_date, :status, :ocr_status, :start_date, :end_date, :is_history

    def initialize(option = {})
        @page                   = option[:page].to_i
        @per                    = option[:per]
        @date                   = option[:date] || DateTime.now.to_date
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
    
    def get_data
        tr_invoices      = DashboardAction::Query::Suspect.new(condition_suspect).suspect_invoices(get_tr_invoices)
        tr_invoices_size = tr_invoices.size

        tr_invoices     = Kaminari.paginate_array(tr_invoices)
        tr_invoice       = tr_invoices.page(page).per(1).first
        tr_invoice_items = tr_invoice[:tr_invoice_items]

        remark = tr_invoice[:validate_reason_id].nil? ? '' : ValidateReason.find_by(id: tr_invoice[:validate_reason_id])[:desc]  
        {
            customer_store_code: tr_invoice[:customer_store_code],
            customer_store_name: tr_invoice[:customer_store_name],
            customer_store_type: tr_invoice[:customer_store_type],
            vat_invoice_number:  tr_invoice[:vat_no],
            invoice_date:        tr_invoice[:invoice_date],
            dc_route_code:       tr_invoice[:dc_route_code],
            remark:              remark,
            tr_invoices_count:   tr_invoices.size,
            tr_invoice_items:    suspect_tr_invoices(tr_invoice_items),
            paging:              perform_page(tr_invoices, tr_invoices_size),
            images:              tr_invoice[:images].pluck(:full_name),
            tr_invoice_id:       tr_invoice[:tr_invoice_id],
            validate_reason_id:	 tr_invoice[:validate_reason_id]
        }
    end

    def suspect_tr_invoices(tr_invoice_items)
        tr_invoice_items_response = []

        tr_invoice_items.each do |tr_invoice_item|

            tr_invoice_items_response << {
                invoice_sequence: tr_invoice_item.invoice_sequence,
                item_code:        tr_invoice_item.item_code,
                short_name:       tr_invoice_item.short_name,
                value_of_unit:    tr_invoice_item.value,
                number:           "1",
                value:            tr_invoice_item.value,
                ocr_item_result:  tr_invoice_item.ocr_item_result
            }
        end

        return tr_invoice_items_response
    end

    def perform_page(tr_invoices, tr_invoices_size)
        page_last  = tr_invoices_size
        page_start = (((page-1)/page_size)*page_size)+1
        page_end   = ((page/5.0).ceil)*5
        {
            is_first:      (page_start == 1),
            is_last:       (page_last <= page_end),
            page_previous: page_start - 1,
            page_next:     page_end + 1,
            page_start:    page_start,
            page_end:      page_end,
            page_last:     page_last,
            page_number:   page,
            total_pages:   tr_invoices.page(1).per(page_size).total_pages
        }
    end

    def condition_suspect
        { 
            status:                 status,
            ocr_status:             ocr_status
        }
    end
end