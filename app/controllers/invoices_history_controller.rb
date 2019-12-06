class InvoicesHistoryController < ApplicationController
    before_action :permit_variable, only: [:index]

    def index
        @data                 = DashboardAction::Query::DashboardHistory.new(condition).get_data
        @summary_invoice      = @data[:summary_invoice]
        @transaction_invoices = @data[:transaction_invoices]
        @filter_list          = @data[:filter_list]
    end

    def permit_params
        params.permit(:filter, :start_date, :end_date)
    end

    def permit_variable
        @index         = 1
        @is_history    = true
        @start_date    = permit_params[:start_date].nil? || permit_params[:start_date] == "วันที่เริ่มต้น" ? "วันที่เริ่มต้น" : permit_params[:start_date].to_date.strftime('%d/%m/%Y')
        @end_date      = permit_params[:end_date].nil?   || permit_params[:end_date] == "วันที่สิ้นสุด"   ? "วันที่สิ้นสุด" : permit_params[:end_date].to_date.strftime('%d/%m/%Y')
        @filter_params = permit_params[:filter].nil? ? "0": permit_params[:filter]
    end

    def condition
        {
            start_date: @start_date,
            end_date:   @end_date,
            is_history: @is_history,
            filter:     @filter_params
        }
    end
end
