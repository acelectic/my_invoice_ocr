class OcrAction::Command::Compare < BaseAction

    attr_reader :ocr_date, :path, :path_done, :path_suspect, :path_waiting, :path_store, :path_suspect_fob, :path_suspect_fp, :path_error, :path_root
    require 'fileutils'

    def initialize(option = {})
        @ocr_date         =  option[:ocr_date] || DateTime.now.to_date
        @path_root        = "app/assets/images/"
        @path             = "ocr_file/#{ocr_date}"
        @path_done        = "#{path}/done/"
        @path_error       = "#{path}/error/"
        @path_store       = "#{path}/file_store/"
        @path_suspect     = "#{path}/suspect/"
        @path_waiting     = "#{path}/waiting/"
        @path_suspect_fob = "#{path}/suspect_fob/"
        @path_suspect_fp  = "#{path}/suspect_false_positive/"
        
        perform_prepare_create_dir
        perform_move_file_store
    end

    def perform_compare
        # get data from directory scaning
        customer_stores      = CustomerStore.get_hash
        perform_data_from_file(customer_stores, ocr_date)
        ocr_invoices         = OcrInvoice.not_yet_compared(ocr_date)
        ms_invoices          = MsInvoice.get_hash(ocr_invoices.pluck(:vat_no))
        
        # let's perform compare
        perform_tr_invoice(ocr_invoices, ms_invoices, ocr_date)
        tr_invoices          = TrInvoice.get_hash
        new_tr_invoice_items = []

        ocr_invoices.each do |ocr_invoice|
            ms_invoice       = ms_invoices[key_ms_invoice(ocr_invoice)]
            puts "error find ms_invoice #{ocr_invoice.inspect}" if ms_invoice.nil?

            key_tr_invoice       = ocr_date.to_s + ms_invoice.id.to_s + ocr_invoice.id.to_s
            tr_invoice           = tr_invoices[key_tr_invoice]

            ms_invoice_item_size = ms_invoice.ms_invoice_items.size
            ms_invoice_items     = ms_invoice.ms_invoice_items

            ocr_invoice_items    = OcrInvoiceItem.create_hash(ocr_invoice.ocr_invoice_items, "invoice_sequence", "class")
            ocr_result           = true

            (1..ms_invoice_item_size).each do |index| 
                ocr_invoice_item    = ocr_invoice_items[index.to_s]
                ms_invoice_item     = ms_invoice_items[index-1]

                tr_invoice_id       = tr_invoice.id
                invoice_sequence    = index
                ocr_item_result     = nil
                ocr_invoice_item_id = nil
                ms_invoice_item_id  = ms_invoice_item.id

                if ocr_invoice_item.nil?
                    ocr_item_result     = is_invoice_item_equal(ms_invoice_item, nil)
                else
                    ocr_item_result     = is_invoice_item_equal(ms_invoice_item, ocr_invoice_item)
                    ocr_invoice_item_id = ocr_invoice_item.id
                end

                new_tr_invoice_items << TrInvoiceItem.new(
                    tr_invoice_id:       tr_invoice_id,
                    invoice_sequence:    invoice_sequence,
                    ocr_item_result:     ocr_item_result,
                    ocr_invoice_item_id: ocr_invoice_item_id,
                    ms_invoice_item_id:  ms_invoice_item_id
                )

                ocr_result = ((ocr_item_result == false) || (ocr_result == false)) ? false : true
            end

            tr_invoice.ocr_result       = ocr_result
            tr_invoices[key_tr_invoice] = tr_invoice

            perform_move_file_compared(ocr_invoice, ocr_result)
        end

        TrInvoice.import_data(tr_invoices.values)
        TrInvoiceItem.import_data(new_tr_invoice_items)
        OcrInvoice.where(id: ocr_invoices.pluck(:id)).update_all(is_compared: true)
    end

    def perform_tr_invoice(ocr_invoices, ms_invoices, ocr_date)
        new_tr_invoices = []

        ocr_invoices.each do |ocr_invoice|
            ms_invoice       = ms_invoices[key_ms_invoice(ocr_invoice)]
            puts "error find ms_invoice #{ocr_invoice.inspect}" if ms_invoice.nil?
            
            new_tr_invoices << new_tr_invoice(false, ocr_date, ms_invoice.id, ocr_invoice.id)
        end
        
        TrInvoice.import_data(new_tr_invoices)
    end

    def is_invoice_item_equal(ms_invoice_item, ocr_invoice_item)
        return false if ocr_invoice_item.nil?
        
        ms_invoice_item_item_id  = ms_invoice_item.item_id
        ms_invoice_item_price    = ms_invoice_item.value

        ocr_invoice_item_item_id  = ocr_invoice_item.item_id
        ocr_invoice_item_price    = ocr_invoice_item.price

        return true if (ms_invoice_item_item_id == ocr_invoice_item_item_id) && (ms_invoice_item_price == ocr_invoice_item_price)
        return false
    end

    def key_ms_invoice(ocr_invoice)
        vat_no              = ocr_invoice.vat_no  
        sequence            = ocr_invoice.sequence
        customer_store_id   = ocr_invoice.customer_store_id
      
        return (vat_no.to_s + sequence.to_s + customer_store_id.to_s)
    end

    def perform_move_file_compared(ocr_invoice, ocr_result)
        new_ocr_invoice_images = []
        ocr_invoice_images     = ocr_invoice.ocr_invoice_images
        destination_path       = (ocr_result == true) ? path_done : path_suspect

        ocr_invoice_images.each do |ocr_invoice_image|
            image_name  = ocr_invoice_image.image_name
            source_path = ocr_invoice_image.full_name

            destination_file            = destination_path + image_name
            ocr_invoice_image.full_name = destination_file
            new_ocr_invoice_images     << ocr_invoice_image
            move_file(source_path, destination_file)
        end
        
        OcrInvoiceImage.import_data(new_ocr_invoice_images)
    end

    def perform_data_from_file(customer_stores, ocr_date)
        datas = get_data_from_ocr

        perform_ocr_invoices(datas, ocr_date, customer_stores)
        perform_ocr_invoice_items(datas, ocr_date, customer_stores)

        puts "ocr invoices saved !!!!"
    end

    def perform_ocr_invoices(datas, ocr_date, customer_stores)
        ocr_invoices       = OcrInvoice.get_hash(ocr_date)
        ocr_invoice_images = OcrInvoiceImage.get_hash(ocr_date)
      
        datas.each do |data|
            error               = data["error"]
            data_invoice        = data["ocr_invoice"]
            vat_no              = data_invoice["vat_no"]
            sequence            = data_invoice["sequence"]
            status              = data_invoice["status"]
            customer_store_code = data_invoice["customer_store_code"]
            total_page          = data_invoice["total_page"]

            if error == "None"
                if customer_stores[customer_store_code].nil?
                    puts "===debug==="
                    puts customer_store_code 
                    next
                end 
                customer_store_id   = customer_stores[customer_store_code].id

                key               = ocr_date.to_s +  customer_store_id.to_s + vat_no.to_s
                ocr_invoices[key] = find_or_initialize_ocr_invoice(ocr_invoices, key, vat_no, sequence, status, customer_store_id, total_page, ocr_date)
            end
        end

        OcrInvoice.import_data(ocr_invoices.values)
    end

    def perform_ocr_invoice_items(datas, ocr_date, customer_stores)
        puts "===debug invoice items===="
        items                  = Item.get_hash
        ocr_invoices           = OcrInvoice.get_hash(ocr_date)
        ocr_invoice_items      = OcrInvoiceItem.get_hash(ocr_date)
        ocr_invoice_images     = OcrInvoiceImage.get_hash(ocr_date)
        source_path            = path_store
        destination_path       = path_waiting
        error_destination_path = path_error

        datas.each do |data|
            error               = data["error"]
            image_name          = data["file_name"]
            data_invoice        = data["ocr_invoice"]
            vat_no              = data_invoice["vat_no"]
            customer_store_code = data_invoice["customer_store_code"]
            page                = data_invoice["page"]

            if error == "None"
                image_name          = data_invoice["file_name"]
                puts "===debug none image name==="
                full_name           = destination_path + image_name
                puts "==========================="
                if customer_stores[customer_store_code].nil?
                    puts "===debug==="
                    puts customer_store_code 
                    next
                end 
                customer_store_id   = customer_stores[customer_store_code].id

                puts "===debug key ocr invoice==="
                key_ocr_invoice                            = ocr_date.to_s +  customer_store_id.to_s + vat_no.to_s
                puts "============================"
                ocr_invoice_id                             = ocr_invoices[key_ocr_invoice].id
                ocr_invoice_items                          = get_ocr_invoice_item(ocr_invoice_items, items, data_invoice["ocr_invoice_items"], ocr_invoice_id, page)
            
                source_file      = source_path + image_name
                destination_file = full_name
                
            else 
                image_name          = data["file_name"]
                ocr_invoice_id   = ""
                page             = ""
                puts "===debug image name==="
                full_name        = error_destination_path + image_name
                puts "======================="
                source_file      = source_path + image_name
                destination_file = full_name
            end

            puts "===debug key ocr invoice image==="
            key_ocr_invoice_image                      = ocr_invoice_id.to_s + ocr_date.to_s + image_name.to_s + page.to_s
            puts "============================"
            ocr_invoice_images[key_ocr_invoice_image]  = find_or_initialize_ocr_invoice_image(ocr_invoice_images, key_ocr_invoice_image, image_name, full_name, page, ocr_date, ocr_invoice_id)
            move_file(source_file, destination_file)
        end
        
        OcrInvoiceItem.import_data(ocr_invoice_items.values)
        OcrInvoiceImage.import_data(ocr_invoice_images.values)
    end

    def get_ocr_invoice_item(ocr_invoice_items, items, params_ocr_invoice_items, ocr_invoice_id, page)
        params_ocr_invoice_items.each do |params_ocr_invoice_item|
            invoice_sequence = params_ocr_invoice_item["invoice_sequence"]
            item             = items["8850123" + params_ocr_invoice_item["item_code"]]
            price            = params_ocr_invoice_item["price"]

            key                    = ocr_invoice_id.to_s + item.to_s
            ocr_invoice_items[key] = find_or_initialize_ocr_invoice_item(ocr_invoice_items, key, invoice_sequence, ocr_invoice_id, item, price, page)
        end

        return ocr_invoice_items
    end

    def find_or_initialize_ocr_invoice(ocr_invoices, key, vat_no, sequence, status, customer_store_id, total_page, ocr_date)
        ocr_invoice = ocr_invoices[key]
        ocr_invoice = new_ocr_invoice(vat_no, sequence, status, customer_store_id, total_page, ocr_date) if ocr_invoice.nil?

        ocr_invoice.is_compared = false
        return ocr_invoice
    end

    def find_or_initialize_ocr_invoice_image(ocr_invoice_images, key, image_name, full_name,page, ocr_date, ocr_invoice_id)
        ocr_invoice_image = ocr_invoice_images[key]
        ocr_invoice_image = new_ocr_invoice_image(image_name, full_name, page, ocr_date, ocr_invoice_id) if ocr_invoice_image.nil?
        
        ocr_invoice_image.full_name = full_name
        return ocr_invoice_image
    end

    def find_or_initialize_ocr_invoice_item(ocr_invoice_items, key, invoice_sequence, ocr_invoice_id, item, price, page)
        ocr_invoice_item = ocr_invoice_items[key]
        ocr_invoice_item = new_ocr_invoice_item(invoice_sequence, ocr_invoice_id, item, price, page) if ocr_invoice_item.nil?

        return ocr_invoice_item
    end

    def new_ocr_invoice(vat_no, sequence, status, customer_store_id, total_page, ocr_date)
        OcrInvoice.new(
            vat_no:              vat_no,
            sequence:            sequence,
            status:              status,
            customer_store_id: customer_store_id,
            total_page:          total_page,
            ocr_date:            ocr_date
        )
    end

    def new_ocr_invoice_item(invoice_sequence, ocr_invoice_id, item, price, page)
        OcrInvoiceItem.new(
            invoice_sequence: invoice_sequence,
            ocr_invoice_id:   ocr_invoice_id,
            item_id:          item.id,
            price:            price,
            page:             page
        )
    end

    def new_ocr_invoice_image(image_name, full_name, page, ocr_date, ocr_invoice_id)
       
        OcrInvoiceImage.new(
            ocr_invoice_id: ocr_invoice_id,
            image_name:     image_name,
            full_name:      full_name,
            ocr_date:       ocr_date,
            page:           page   
        )
    end

    def new_tr_invoice(ocr_result, ocr_date, ms_invoice_id, ocr_invoice_id)
        TrInvoice.new(
            ocr_date:       ocr_date,
            ocr_result:     ocr_result,
            ms_invoice_id:  ms_invoice_id,
            ocr_invoice_id: ocr_invoice_id
        )
    end

    def perform_prepare_create_dir
        perform_create_dir(path)
        perform_create_dir(path_done)
        perform_create_dir(path_error)
        perform_create_dir(path_store)
        perform_create_dir(path_suspect)
        perform_create_dir(path_waiting)
        perform_create_dir(path_suspect_fob)
        perform_create_dir(path_suspect_fp)
    end

    def move_file(source_file, destination_file)
        FileUtils.mv(path_root + source_file, path_root + destination_file, force: true)
    end

    def perform_create_dir(path)
        path = Rails.root + path_root + path
        system("mkdir #{path}")
    end

    def perform_move_file_store
        source_path = "ocr_file/file_store"
        FileUtils.copy_entry(path_root + source_path, path_root + path_store)
    end

    def get_data_from_ocr
        # mock_up      = OcrAction::Command::MockUp.new
        # data     = [
        #     mock_up.mock_ocr_invoice_first_1,
        #     mock_up.mock_ocr_invoice_first_2,
        #     mock_up.mock_ocr_invoice_second_1,
        #     mock_up.mock_ocr_invoice_second_2,
        #     mock_up.mock_ocr_invoice_third_1
        # ]

        data    = []
        results = `python /Users/manny/Desktop/invoice-validator-ai/operation/starter.py -p "/Users/manny/Desktop/invoice-ocr/app/assets/images/ocr_file/store_image/"`
        results = results.split("#***#")
        results = results.drop(1)  

        results.each do |result|
            data << JSON.parse(result)
        end

        return data
    end

end