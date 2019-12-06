class DashboardAction::Query::Search < DashboardAction::Query::Suspect

    attr_reader :word

    def initialize(option = {})
       @word = option[:word]
       @status                 = option[:status].nil? ? "0" : option[:status]
       @ocr_status             = option[:ocr_status].nil? ? "0" : option[:ocr_status]
    end

    def get_data
        tr_invoices = TrInvoice.search(word)
        return { suspect_invoices: suspect_invoices(tr_invoices) }
    end
    
end