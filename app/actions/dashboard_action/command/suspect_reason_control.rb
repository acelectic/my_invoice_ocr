class DashboardAction::Command::SuspectReasonControl < BaseAction
    def update_reason(option ={})
        puts "ssss"
        puts option
        TrInvoice.update_reason(validate_reason_id: option[:validate_reason_id], tr_invoice_id: option[:tr_invoice_id])
    end
end