# == Schema Information
#
# Table name: UNIT_OF_MEASURE
#
#  company_code   :string(3)
#  um_code        :string(4)        primary key
#  description    :string(255)
#  alternate_name :string(255)
#  status         :string(1)
#  created_by     :string(20)
#  created_date   :date
#  last_upd_by    :string(20)
#  last_upd_date  :date
#
# Indexes
#
#  idx_unit_ofme  (company_code,um_code)
#

class DbsaleUnitOfMeasure < DbsaleBase
  self.table_name = 'UNIT_OF_MEASURE'
  include AliasLegacyColumns
  self.primary_keys = :um_code
end
