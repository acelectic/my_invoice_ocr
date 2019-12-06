require Rails.root.join('lib', 'ojdbc6.jar')

class DbsaleBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "dbsale_#{Rails.env}".to_sym

  def self.event_table_name
    "DBS_#{table_name}"
  end
end
