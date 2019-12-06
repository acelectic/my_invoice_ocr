class DashboardAction::Query::Dashboard < BaseAction

	attr_reader :date, :filter, :start_date, :end_date, :is_history

    def initialize(option = {})
		@date       = option[:date]
		@filter     = option[:filter].nil? ? "0" : option[:filter]
		@is_history = option[:is_history]
    end

	def get_data
		tr_invoices          = TrInvoice.with_date(date)
		distribution_centers = DistributionCenter.invoices_with_date(date)

		{ 
			verify_date:          date, 
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
			incomplete_verified_invoice_qty: OcrInvoice.incomplete_count(date),
			unverifiable_invoice_qty:        get_count_unverifiables,
			incomplete_verified: 			 OcrInvoiceImage.incomplete(date),
			unverifiable_invoice:            OcrInvoiceImage.unverifiable(date)
		}
	end

	def transaction_invoices(distribution_centers)
		response_distribution_centers = []        

		distribution_centers.each do |distribution_center|
			verify_status                = TrInvoice.status_verify_ocr_result(distribution_center.tr_invoices)
			response_distribution_center = {
					distribution_center_id:       distribution_center.id,
					distribution_center_code:     distribution_center.distribution_center_code,
					distribution_center_name:     distribution_center.distribution_center_name,
					total_verified_invoice_qty:   distribution_center.tr_invoices.size,
					correct_verified_invoice_qty: TrInvoice.count_result_true(distribution_center.tr_invoices),
					suspect_verified_invoice_qty: TrInvoice.count_result_false(distribution_center.tr_invoices),
					is_verified:                  verify_status
				}

			if is_reponse(verify_status)
				response_distribution_centers << response_distribution_center
			end
		end

		return response_distribution_centers
	end

	def is_reponse(verify_status)
		return (filter == "0") || (filter == "1" && verify_status == true) || (filter == "2" && verify_status == false) 
	end

	def params_filter
		return nil   if filter == "0"
		return true  if filter == "1"
		return false if filter == "2"
	end

	def get_count_unverifiables
		ocr_file_path = "app/assets/images/ocr_file/"
		count_unverifiable  = perform_count_unverifiables(ocr_file_path + "#{date}/")	
	
		return count_unverifiable
	end

	def perform_count_unverifiables(path)
		root_path          = "app/assets/images/ocr_file/#{start_date}/"
		unverifiable_path  = root_path + "error/"

		return  Dir[File.join(unverifiable_path, '**', '*.jpg')].count 
	end
end