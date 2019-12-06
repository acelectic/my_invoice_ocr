require 'test_helper'


class DashBoardTest < ActiveSupport::TestCase

    test "list_table_invoice_result_today" do
        data = DashboardAction::Query::List.new.dashboard_list
        assert_equal([:verify_date, :summary_invoice, :transaction_invoices], data.keys)

        verify_date = data[:verify_date]
        assert_equal(verify_date, DateTime.now.to_date)

        summary_invoice = data[:summary_invoice]
        assert_not_empty(summary_invoice)
        assert_equal(
            [
                :total_verified_invoice_qty, 
                :correct_verified_invoice_qty, 
                :suspect_verified_invoice_qty, 
                :incomplete_verified_invoice_qty,
                :unverifiable_invoice_qty,
                :incomplete_verified,
                :unverifiable_invoice
            ], summary_invoice.keys
        )
        
        transaction_invoices = data[:transaction_invoices]
        assert_not_empty(transaction_invoices)

        transaction_invoices_first = transaction_invoices.first
        assert_equal(
            [
                :distribution_center_id,
                :distribution_center_code,
                :distribution_center_name,
                :total_verified_invoice_qty,
                :correct_verified_invoice_qty,
                :suspect_verified_invoice_qty,
                :is_verified
            ], transaction_invoices_first.keys
        )
    end
    
    
    
end