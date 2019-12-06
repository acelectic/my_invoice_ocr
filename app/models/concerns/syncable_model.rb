module SyncableModel
  extend ActiveSupport::Concern

  module ClassMethods
    def last_synced_at_key
      "#{name.underscore}_last_synced_at"
    end

    def last_synced_at=(val)
      AppSetting.send("#{last_synced_at_key}=", val)
    end

    def default_last_sync
      DateTime.new(2000, 1, 1)
    end

    def last_synced_at
      synced_at = AppSetting.send(last_synced_at_key)
      synced_at.nil? ? default_last_sync : synced_at
    end

    def get_oracle_last_update
      "TO_DATE('#{last_synced_at.strftime("%d/%m/%Y %H:%M:%S")}', 'dd/mm/yyyy HH24:MI:SS')"
    end

    def event_table_name
      "SMT_#{name.underscore.upcase}"
    end

    def log_sync(job_id = nil, job_name = nil, from_table, to_table, query, &block)
      db_sale_quey_count = 0
      smart_dc_insert_count = 0
      event_start_date = DateTime.now

      begin
        db_sale_quey_count, smart_dc_insert_count, result = yield 
      rescue Exception => exception
        error = exception.message
      end
      event_end_date = DateTime.now

      log_message(
        job_id,
        job_name,
        from_table.event_table_name,
        db_sale_quey_count,
        to_table.event_table_name,
        smart_dc_insert_count,
        query,
        event_start_date,
        event_end_date,
        result,
        error
      )
    end

    def log_message(job_id = nil, job_name = nil, from_table, from_count, to_table, to_count, query, start_date, end_date, result, error)
      EventLog.create(
        {
          event_type:       EventLog::TYPE_DETAIL,
          job_id:           job_id,
          job_name:         job_name,
          result:           error.nil? ? result ||'success' : error,
          event_start_date: start_date,
          event_end_date:   end_date,
          job_duration:     format_job_duration_time(end_date.to_time - start_date.to_time),
          from_table:       from_table,
          to_table:         to_table,
          from_count:       from_count,
          to_count:         to_count,
          query:            query.present? ? query.instance_of?(String) ? query.delete("\n") : query.to_sql.delete("\n") : nil
        }
      )
      raise Exception.new(error) unless error.nil?
    end

    def get_scope_customer_store_code
      "SELECT DISTINCT CUSTOMER_CODE FROM CUSTOMER_VISIT_DETAIL " +
      "WHERE (SUBSTR(STORE_ID, 0, 4) IN ('1101', '1301', '1201','1103','1501','1801','1701','1601','1504')) " +
        " AND (START_DATE > TO_DATE('01/01/2015', 'dd/mm/yyyy HH24:MI:SS'))"
    end

    def get_scope_customer_code
      "SELECT DISTINCT SUBSTR(CUSTOMER_CODE, 0, 5) FROM CUSTOMER_VISIT_DETAIL " +
      "WHERE (SUBSTR(STORE_ID, 0, 4) IN ('1101', '1301', '1201','1103','1501','1801','1701','1601','1504')) " +
        " AND (START_DATE > TO_DATE('01/01/2015', 'dd/mm/yyyy HH24:MI:SS'))"
    end

    def create_hash(model_array, hash_key, value_key = nil)
      h = {}

      model_array.each do |m|
        if hash_key.class == Array
          real_key = ""
          hash_key.each do |h_key|
            real_key = real_key + m.attributes[h_key].to_s
          end
          if value_key.nil?
            h[real_key] = m.attributes["id"]
          else
            h[real_key] = m
          end
        else
          if value_key.nil?
            h[m.attributes[hash_key]] = m.attributes["id"]
          else
            if value_key == "class"
              h[m.attributes[hash_key]] = m
            else
              h[m.attributes[hash_key]] = m.attributes[value_key]
            end
          end
        end
      end
      h
    end

    def format_job_duration_time(t)
      "%02d:%02d:%02d" % [t/3600%24, t/60%60, t%60]
    end

    private

    def generate_error_message(message_hash)
      "
        #{get_common_message(message_hash)}
        Exception: #{message_hash[:exception_message]}
      "
    end

    def set_nil(*args)
      args.each do |arg|
        arg = nil
      end
    end

    def is_nil?(*fields)
      fields.each do |field|
        return true if field.nil?
      end
      return false
    end
    
  end
end
