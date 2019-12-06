require 'test_helper'


class OcrTest < ActiveSupport::TestCase
		

		def setup
			@datas             = OcrAction::Command::Compare.new.get_data_from_ocr
			@ocr_date          = DateTime.now.to_date
		end

		
		test "perform_ocr_invoices" do
				data = test_method_perform_ocr_invoices
				assert_not_empty(data)
				assert_equal([:ocr_invoices], data.keys)

				ocr_invoices = data[:ocr_invoices]
				assert_not_empty(ocr_invoices)

				ocr_invoices_first = ocr_invoices.first
					assert_equal([
						:customer_store_code,
						:net_price,          
						:ocr_date,           
						:sequence,           
						:status,             
						:total_page,         
						:vat_no ],
					 ocr_invoices_first.keys)    
		end
		
		focus
		test "perform_ocr_invoice_items" do
			data = test_method_perform_ocr_invoice_items
			assert_not_empty(data)
			assert_equal([:ocr_invoice_items, :ocr_invoice_images], data.keys)

			puts "####	DEBUG	####"
			ocr_invoice_items = data[:ocr_invoice_items]
			assert_not_empty(ocr_invoice_items)
			ocr_invoice_item_first = ocr_invoice_items.first
				assert_equal([
					:ocr_invoice_id,
					:invoice_sequence,
					:page,            
					:price,           
					:item_id],
					ocr_invoice_item_first.keys)
			puts "####	Item OK Jaa ####"

			ocr_invoice_images = data[:ocr_invoice_images]
			assert_not_empty(ocr_invoice_images)
			ocr_invoice_image_first = ocr_invoice_images.first
				assert_equal([
						:ocr_invoice_id,
						:full_name,     
						:image_name,    
						:ocr_date,      
						:page,         ],
						ocr_invoice_image_first.keys)
			puts "####	Image OK Jaa ####"
			
			
			
	end



	def test_method_perform_ocr_invoices
		OcrAction::Command::Compare.new.perform_ocr_invoices(@datas, @ocr_date)
		
		item = OcrInvoice.first 
		
		{
				ocr_invoices:[
						{
							customer_store_code:		item.customer_store_code,
							net_price:          		item.net_price,
							ocr_date:           		item.ocr_date,           
							sequence:           		item.sequence,           
							status:             		item.status,             
							total_page:         		item.total_page,         
							vat_no:             		item.vat_no             
					}
				]
		}
	end

	def test_method_perform_ocr_invoice_items
		OcrAction::Command::Compare.new.perform_ocr_invoices(@datas, @ocr_date)
		OcrAction::Command::Compare.new.perform_ocr_invoice_items(@datas, @ocr_date)
		
		item = OcrInvoiceItem.first 
		image = OcrInvoiceImage.first 

		{
				ocr_invoice_items:[
					{

						ocr_invoice_id:				item.ocr_invoice_id,
						invoice_sequence:			item.invoice_sequence,
						page:            			item.page,            
						price:           			item.price,                
						item_id:         			item.item_id         
       
					}
				],
				ocr_invoice_images:[
					{
						ocr_invoice_id:				image.ocr_invoice_id,
						full_name:     				image.full_name,     
						image_name:    				image.image_name,    
						ocr_date:      				image.ocr_date,      
						page:          				image.page,         
					}
				]

		}
	end


end
