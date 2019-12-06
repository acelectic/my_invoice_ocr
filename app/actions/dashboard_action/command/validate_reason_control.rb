class DashboardAction::Command::ValidateReasonControl < BaseAction
   
    def initialize
        @used_reasons = get_used_reasons
    end

    def get_used_reasons
        used_reasons = []
        TrInvoice.get_verify_list.each do |u|

            reason_id = u[:validate_reason_id]
            # puts reason_id
            if reason_id != nil
                used_reasons << reason_id
            end
        end
        
        return used_reasons
    end
    
    def add_reason(option = {})    

        reason_type = option[:reason_type]

        if ['0', '1'].include? reason_type
            puts '######################DEBUG2###############################3'
            v = ValidateReason.new(
                reason_code:    option[:reason_code],
                desc:           option[:desc],
                is_active:      option[:is_active],
                creator:     option[:user_id],
                updator:     option[:user_id],
                reason_type: reason_type
            )
            ValidateReason.add_reason(v)
        end
      
    end

    def get_data

        valid_reason = ValidateReason.perform_valid_reasons
        invalid_reason = ValidateReason.perform_invalid_reasons
        {
            valid_reason: mark_is_used(valid_reason),
            invalid_reason: mark_is_used(invalid_reason)
        }
    end

    def mark_is_used(reasons)
        result = []
        reasons.each do |reason|
            is_used = @used_reasons.include? reason[:id]
            data = {
                reason_id:      reason[:id],
                reason_code:    reason[:reason_code],
                desc:           reason[:desc],
                is_active:      reason[:is_active],
                creator:        reason[:creator],
                updator:        reason[:updator],
                reason_type:    reason[:reason_type],
                is_used:        is_used
            }
            result << data
        end

        result

    end

    def new_reason4test
        uids = ["123456","111111", "998745"]
        5.times do |u|
            uid = uids.sample
            v = ValidateReason.new(
                reason_code:    "F"+ u.to_s.rjust(2, '0'),
                desc:           "Hello_"+ u.to_s.rjust(2, '0'),
                is_active:      true,
                creator:     uid,
                updator:     uid,
                reason_type: false
            )
            if v.save
                puts 'created' 
            end
        end

        7.times do |u|
            uid = uids.sample
            v = ValidateReason.new(
                reason_code:   "T" +  u.to_s.rjust(2, '0'),
                desc:           "Bye_"+ u.to_s.rjust(2, '0'),
                is_active:      true,
                creator:     uid,
                updator:     uid,
                reason_type: true
            )
            if v.save
                puts 'created' 
            end
        end
        
    end
end