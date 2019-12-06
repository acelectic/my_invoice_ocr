# == Schema Information
#
# Table name: STOCK_SUB_CATEGORY
#
#  company_code      :string(3)        not null
#  category_code     :string(10)       not null, primary key
#  sub_category_code :string(10)       not null, primary key
#  description       :string(255)
#  alternate_name    :string(255)
#  created_by        :string(20)
#  created_date      :date
#  last_upd_by       :string(20)
#  last_upd_date     :date
#  status            :string(1)
#

class DbsaleStockSubCategory < DbsaleBase
  self.table_name = 'STOCK_SUB_CATEGORY'
  include AliasLegacyColumns
  self.primary_keys = :category_code, :sub_category_code
end
