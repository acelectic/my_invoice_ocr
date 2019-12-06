class SearchInvoicesController < ApplicationController
    before_action :permit_variable, only: [:index, :show]

    def index
        @data = DashboardAction::Query::Search.new(condition).get_data
    end

    def permit_params
        params.permit(:word)
    end

    def permit_variable
        @index     = 1 
        @is_search = true
        @word      = permit_params[:word].nil? ? nil : permit_params[:word]
    end

    def condition
        {
            word: @word
        }
    end
end
