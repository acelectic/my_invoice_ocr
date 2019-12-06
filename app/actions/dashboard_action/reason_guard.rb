class DashboardAction::ReasonGuard < BaseAction

    attr_reader :reasons,:reason_code, :desc_is_exists

    def initialize
        @reasons = ValidateReason.perform_reasons
    end

    def check_params(option)
        return false if option[:reason_code].blank?
        return false if option[:desc].blank?
        return false if option[:is_active].blank?
        return false if option[:user_id].blank?
        return true
    end

    def can_add_reason(option)
        puts option

        @reason_code = option[:reason_code]
        @desc        = option[:desc]

        if code_is_exists?
            puts 'code exists'
            return [false, 'เหตุผลมีการใช้งานอยู่'] if reason_is_used?
            return [false, 'เหตุผลซ้ำ']         if desc_is_exists?
            return [true, 'ทำรายการได้']
        else
            return [false, 'เหตุผลซ้ำ'] if desc_is_exists?
            return [true, 'ทำรายการได้']
        end
    end

    def code_is_exists?
        return false if reasons.where(reason_code: reason_code).nil?
        return true 
    end
 

    def desc_is_exists?
        return false if reasons.find_by(desc :desc).nil?
        return true 
    end

    def reason_is_used?
       return false if reasons.find_by(reason_code: reason_code).tr_invoices.count.nil?
       return true
    end

end