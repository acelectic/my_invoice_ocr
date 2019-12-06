class InvoicesController < ApplicationController
    before_action :permit_variable, only: [:index]

    def index
        @data                 = DashboardAction::Query::Dashboard.new(condition).get_data
        @summary_invoice      = @data[:summary_invoice]
        @transaction_invoices = @data[:transaction_invoices]
        @filter_list          = @data[:filter_list]
    end

    def permit_params
        params.permit(:filter)
    end

    def permit_variable
        @index         = 1
        @ocr_date      = DateTime.now.to_date
        @filter_params = permit_params[:filter].nil? ? "0": permit_params[:filter]
    end

    def condition
        {
            date:  @ocr_date, 
            filter: @filter_params
        }
    end

end
