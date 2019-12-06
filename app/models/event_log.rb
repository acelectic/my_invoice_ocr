# == Schema Information
#
# Table name: event_logs
#
#  id                       :bigint           not null, primary key
#  event_type               :string(30)       not null
#  from_table               :string(100)
#  to_table                 :string(100)
#  from_count               :integer
#  to_count                 :integer
#  query                    :text(65535)
#  distribution_center_code :string(6)
#  dc_route_code            :string(10)
#  event_start_date         :datetime
#  event_end_date           :datetime
#  result                   :string(500)
#  job_duration             :string(50)
#  job_id                   :string(75)
#  job_name                 :string(70)
#  creator_id               :integer
#  remarks                  :string(300)
#  progress                 :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class EventLog < ApplicationRecord
    TYPE_SERVICE  = "service".freeze
    TYPE_MANUAL   = "manual".freeze
    TYPE_DETAIL   = "service_detail".freeze

end
