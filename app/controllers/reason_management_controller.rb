class ReasonManagementController < ApplicationController
    before_action :permit_variable, only: [:index]
    skip_before_action :verify_authenticity_token
    
    

    def index
        @datas =  DashboardAction::Command::ValidateReasonControl.new.get_data
        @valid_reason = @datas[:valid_reason] 
        @invalid_reason = @datas[:invalid_reason]
        @data = @reason_type.to_i == 0 ? @invalid_reason : @valid_reason
        @reason_type = permit_params[:reason_type].nil? ? '0' : permit_params[:reason_type]
        @alert = permit_params[:alert].nil? ? '' : permit_params[:alert]

    end

    def permit_variable
        @index_valid         = 1
        @index_invalid         = 1
        @reason_type = permit_params[:reason_type].nil? ? '0' : permit_params[:reason_type]
        @active_list = ['Active', 'Inactive']
        @checkvar = true
        @user_id = "555555"
        @alert = permit_params[:alert].nil? ? '' : permit_params[:alert]
    end

    def new
        puts "===debug==="
        puts permit_params
        is_cancel = permit_params[:cancel].nil? ? false : permit_params[:cancel] == 'false' ? false : true

        if is_cancel == true
            puts is_cancel
            redirect_to "/reason_management?reason_type=" + permit_params[:reason_type]
        else        
            puts 'add new reason'

            option = {
                reason_type:        permit_params[:reason_type],
                reason_code:        permit_params[:reason_code],
                desc:               permit_params[:desc],
                user_id:            permit_params[:user_id],
                is_active:          permit_params[:is_active]
            }
            reason_guard = DashboardAction::ReasonGuard.new
            if reason_guard.check_params(option)
                can_add, msg =  reason_guard.can_add_reason(option)
                puts can_add
                puts msg
                if can_add
                    save_report = DashboardAction::Command::ValidateReasonControl.new.add_reason(option)
                    msg = ''
                end
                
                redirect_to reason_management_path reason_type: permit_params[:reason_type], alert: msg
            
            end
        end
    end

    def permit_params
        params.permit(:reason_type, :reason_code, :desc, :user_id, :is_active, :cancel, :check_dup, :alert)
    end
end
