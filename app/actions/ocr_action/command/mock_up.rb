class OcrAction::Command::MockUp < BaseAction

    def mock_ocr_invoice_first_1
        {
            ocr_invoice: {
                vat_no:     "1908JZ0643",
                sequence:   "00013",
                status:     "normal", 
                customer_store_code: "1018001885",
                total_page: 2,
                net_price:  487.05,
                page:       1,
                file_name:  "Quality2_00002.jpg",
                ocr_invoice_items: [
                    {
                        invoice_sequence: 1,
                        item_code:        "110108",
                        price:             27.59,
                    },
                    {
                        invoice_sequence: 2,
                        item_code:        "110115",
                        price:             29.12,
                    },
                    {
                        invoice_sequence: 3,
                        item_code:        "110351",
                        price:             18.40,
                    },
                    {
                        invoice_sequence: 4,
                        item_code:        "110801",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 5,
                        item_code:        "110351",
                        price:             18.40,
                    },
                ]
            }
        }
    end

    def mock_ocr_invoice_first_2
        {
            ocr_invoice: {
                vat_no:     "1908JZ0643",
                sequence:   "00013",
                status:     "normal", 
                customer_store_code: "1018001885",
                total_page: 2,
                net_price:  487.05,
                page:       2,
                file_name:  "Quality2_00003.jpg",
                ocr_invoice_items: [
                    {
                        invoice_sequence: 28,
                        item_code:        "123283",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 29,
                        item_code:        "123290",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 30,
                        item_code:        "180767",
                        price:             10.72,
                    },
                    {
                        invoice_sequence: 31,
                        item_code:        "180774",
                        price:             5.36,
                    },
                    {
                        invoice_sequence: 32,
                        item_code:        "180798",
                        price:             5.36,
                    },
                ]
            }
        }
    end

    def mock_ocr_invoice_second_1
        {
            ocr_invoice: {
                vat_no:     "1908JZ0644",
                sequence:   "00013",
                status:     "normal", 
                customer_store_code: "1018027699",
                total_page: 2,
                net_price:  325.45,
                page:       1,
                file_name:  "Quality2_00004.jpg",
                ocr_invoice_items: [
                    {
                        invoice_sequence: 1,
                        item_code:        "110108",
                        price:             0,
                    },
                    {
                        invoice_sequence: 2,
                        item_code:        "110344",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 3,
                        item_code:        "110351",
                        price:             0,
                    },
                    {
                        invoice_sequence: 6,
                        item_code:        "110849",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 7,
                        item_code:        "110856",
                        price:             7.66,
                    },
                ]
            }
        }
    end
    
    def mock_ocr_invoice_second_2
        {
            ocr_invoice: {
                vat_no:     "1908JZ0644",
                sequence:   "00013",
                status:     "normal", 
                customer_store_code: "1018027699",
                total_page: 2,
                net_price:  325.45,
                page:       2,
                file_name:  "Quality2_00005.jpg",
                ocr_invoice_items: [
                    {
                        invoice_sequence: 29,
                        item_code:        "180767",
                        price:             16.08,
                    },
                    {
                        invoice_sequence: 30,
                        item_code:        "180774",
                        price:             16.08,
                    },
                    {
                        invoice_sequence: 31,
                        item_code:        "180798",
                        price:             5.36,
                    },
                    {
                        invoice_sequence: 32,
                        item_code:        "390036",
                        price:             18.40,
                    },
                    {
                        invoice_sequence: 33,
                        item_code:        "150500",
                        price:             18.40,
                    },
                    {
                        invoice_sequence: 34,
                        item_code:        "150517",
                        price:             0.00,
                    },
                ]
            }
        }
    end

    def mock_ocr_invoice_third_1
        {
            ocr_invoice: {
                vat_no:     "1908JZ0642",
                sequence:   "00013",
                status:     "normal", 
                customer_store_code: "1018009532",
                total_page: 1,
                net_price:  396.85,
                page:       1,
                file_name:  "Quality2_00006.jpg",
                ocr_invoice_items: [
                    {
                        invoice_sequence: 1,
                        item_code:        "110108",
                        price:             55.18,
                    },
                    {
                        invoice_sequence: 2,
                        item_code:        "110115",
                        price:             43.68,
                    },
                    {
                        invoice_sequence: 3,
                        item_code:        "110146",
                        price:             20.69,
                    },
                    {
                        invoice_sequence: 4,
                        item_code:        "110535",
                        price:             39.86,
                    },
                    {
                        invoice_sequence: 5,
                        item_code:        "110351",
                        price:             9.20,
                    },
                    {
                        invoice_sequence: 6,
                        item_code:        "110801",
                        price:             22.98,
                    },
                    {
                        invoice_sequence: 7,
                        item_code:        "110818",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 8,
                        item_code:        "110849",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 9,
                        item_code:        "110894",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 10,
                        item_code:        "111402",
                        price:             13.80,
                    },
                    {
                        invoice_sequence: 11,
                        item_code:        "120589",
                        price:             0,
                    },
                    {
                        invoice_sequence: 12,
                        item_code:        "120640",
                        price:             0,
                    },
                    {
                        invoice_sequence: 13,
                        item_code:        "120657",
                        price:             3.83,
                    },
                    {
                        invoice_sequence: 14,
                        item_code:        "120701",
                        price:             3.83,
                    },
                    {
                        invoice_sequence: 15,
                        item_code:        "120718",
                        price:             3.83,
                    },
                    {
                        invoice_sequence: 16,
                        item_code:        "120725",
                        price:             3.83,
                    },
                    {
                        invoice_sequence: 17,
                        item_code:        "120732",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 18,
                        item_code:        "120787",
                        price:             7.66,
                    },
                    {
                        invoice_sequence: 19,
                        item_code:        "125027",
                        price:             15.32,
                    },
                    {
                        invoice_sequence: 20,
                        item_code:        "180767",
                        price:             5.36,
                    },
                    {
                        invoice_sequence: 21,
                        item_code:        "180774",
                        price:             5.36,
                    },
                    {
                        invoice_sequence: 22,
                        item_code:        "180897",
                        price:             6.13,
                    },
                    {
                        invoice_sequence: 23,
                        item_code:        "396069",
                        price:             22.98,
                    },
                    {
                        invoice_sequence: 24,
                        item_code:        "150500",
                        price:             18.40,
                    },
                    {
                        invoice_sequence: 25,
                        item_code:        "150517",
                        price:             18.40,
                    },
                    {
                        invoice_sequence: 26,
                        item_code:        "392016",
                        price:             15.33,
                    },
                    {
                        invoice_sequence: 27,
                        item_code:        "194177",
                        price:             4.60,
                    },
                ]
            }
        }
    end
end