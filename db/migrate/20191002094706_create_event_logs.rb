class CreateEventLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :event_logs do |t|

      t.string   :event_type,               limit: 30, null: false
      t.string   :from_table,               limit: 100
      t.string   :to_table,                 limit: 100
      t.integer  :from_count               
      t.integer  :to_count                 
      t.text     :query,                    limit: 65535
      t.string   :distribution_center_code, limit: 6
      t.string   :dc_route_code,            limit: 10
      t.datetime :event_start_date         
      t.datetime :event_end_date           
      t.string   :result,                   limit: 500
      t.string   :job_duration,             limit: 50
      t.string   :job_id,                   limit: 75
      t.string   :job_name,                 limit: 70
      t.integer  :creator_id               
      t.string   :remarks,                  limit: 300
      t.integer  :progress                 
      t.timestamps
      
    end
  end
end
