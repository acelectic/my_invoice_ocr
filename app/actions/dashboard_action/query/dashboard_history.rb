class DashboardAction::Query::DashboardHistory < DashboardAction::Query::Dashboard

	attr_reader :start_date, :filter, :end_date

    def initialize(option = {})
		@start_date   = option[:start_date] == "วันที่เริ่มต้น" ? nil : option[:start_date].to_date
		@end_date     = option[:end_date]   == "วันที่สิ้นสุด"  ? nil : option[:end_date].to_date
		@filter       = option[:filter].nil? ? "0" : option[:filter]
    end

	def get_data
		tr_invoices          = TrInvoice.with_date_range(start_date, end_date)
		distribution_centers = DistributionCenter.invoices_with_date_range(start_date, end_date)
		
		{ 
			verify_date:          start_date, 
			summary_invoice:      summary_invoice(tr_invoices), 
			transaction_invoices: transaction_invoices(distribution_centers),
			filter_list:		  ["สถานะการตรวจ", "สมบูรณ์", "ไม่สมบูรณ์"]
		}
	end

	def summary_invoice(tr_invoices)
		{
			total_verified_invoice_qty:      tr_invoices.size,
			correct_verified_invoice_qty:    TrInvoice.count_result_true(tr_invoices),
			suspect_verified_invoice_qty:    TrInvoice.count_result_false(tr_invoices),
			incomplete_verified_invoice_qty: OcrInvoice.incomplete_history_count(start_date, end_date),
			unverifiable_invoice_qty:        get_count_unverifiables,
			incomplete_verified: 			 OcrInvoiceImage.incomplete_history(start_date, end_date),
			unverifiable_invoice:            OcrInvoiceImage.unverifiable_history(start_date, end_date)
		}
	end
	
	def get_count_unverifiables
		count_unverifiable  = 0

		if start_date.nil? && end_date.nil?
			count_unverifiable = 0
		elsif end_date.nil?
			last_date = DateTime.now.to_date
			(start_date..last_date).each do |date|
				count_unverifiable += perform_count_unverifiables("app/assets/images/ocr_file/#{date}/")
			end
		elsif start_date.nil?
			first_date = TrInvoice.first.ocr_date
			(first_date..end_date).each do |date|
				count_unverifiable += perform_count_unverifiables("app/assets/images/ocr_file/#{date}/")
			end
		else
			(start_date..end_date).each do |date| 
				count_unverifiable = perform_count_unverifiables("app/assets/images/ocr_file/#{date}/")
			end
		end
		
		return count_unverifiable
	end

end