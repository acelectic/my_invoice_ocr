class SuspectInvoicesHistoryController < ApplicationController
    before_action :permit_variable, only: [:index, :show]

    def index
        @data                 = DashboardAction::Query::SuspectHistory.new(condition_suspect).get_data
        @dc_routes_code_list  = @data[:dc_routes_code]
        @invoice_date_list    = @data[:invoice_date]
        @status_list          = @data[:status]
        @ocr_status_list      = @data[:ocr_status]
    end

    def show
        @data             = VerifyAction::Query::TrInvoiceItemHistory.new(condition_invoice).get_data
        @tr_invoice_items = @data[:tr_invoice_items]
        @paging           = @data[:paging]
        @images           = @data[:images]

    
        @reasons          = DashboardAction::Command::ValidateReasonControl.new.get_data
        @valid_reasons    =  @reasons[:valid_reason] 
        @invalid_reasons  =  @reasons[:invalid_reason] 
    
        @this_page        = '/suspect_invoice_history'

        add_reason = permit_params[:add_reason].nil? ? false : permit_params[:add_reason] == "true" ? true : false
       
        if add_reason 
            option = {
                validate_reason_id:     permit_params[:reason_id],
                tr_invoice_id:          permit_params[:tr_invoice_id],

            }


            DashboardAction::Command::SuspectReasonControl.new.update_reason(option)

            return true
        end
    end


    def permit_params
        params.permit(:distribution_center_id, :start_date, :end_date, :dc_route_code, :invoice_date, :status, :ocr_status, :page, :image_index, :filter, :is_history, :reason_id, :tr_invoice_id, :add_reason)
    end

    def permit_variable
        @index                  = 1
        @is_history             = true
        @distribution_center_id = permit_params[:distribution_center_id]
        @page                   = permit_params[:page]
        @start_date             = (permit_params[:start_date].nil? or permit_params[:start_date] == "วันที่เริ่มต้น") ? "วันที่เริ่มต้น" : permit_params[:start_date].to_date.strftime('%d/%m/%Y')
        @end_date               = (permit_params[:end_date].nil?   or permit_params[:end_date]   == "วันที่สิ้นสุด")  ? "วันที่สิ้นสุด" : permit_params[:end_date].to_date.strftime('%d/%m/%Y')
        @filter_params          = permit_params[:filter]
        @image_index            = permit_params[:image_index].nil? ? 0 : permit_params[:image_index].to_i        
        @dc_route_code_params   = permit_params[:dc_route_code].nil? ? nil : permit_params[:dc_route_code]
        @invoice_date_params    = permit_params[:invoice_date].nil? ? nil : permit_params[:invoice_date]
        @status_params          = permit_params[:status].nil? ? nil : permit_params[:status]
        @ocr_status_params      = permit_params[:ocr_status].nil? ? nil : permit_params[:ocr_status]
    end

    def condition_suspect
        { 
            start_date:             @start_date,
            end_date:               @end_date,
            is_history:             @is_history,
            distribution_center_id: @distribution_center_id,  
            dc_route_code:          @dc_route_code_params,
            invoice_date:           @invoice_date_params,
            status:                 @status_params,
            ocr_status:             @ocr_status_params
        }
    end

    def condition_invoice
        { 
            page:                   @page,
            start_date:             @start_date,
            end_date:               @end_date,
            is_history:             @is_history,
            distribution_center_id: @distribution_center_id,
            dc_route_code:          @dc_route_code_params,
            invoice_date:           @invoice_date_params,
            status:                 @status_params,
            ocr_status:             @ocr_status_params
        }
    end

end
