# == Schema Information
#
# Table name: STOCK_CATEGORY
#
#  company_code         :string(3)        not null
#  category_code        :string(10)       not null, primary key
#  description          :string(255)
#  alternate_name       :string(255)
#  created_by           :string(20)
#  created_date         :date
#  last_upd_by          :string(20)
#  last_upd_date        :date
#  status               :string(1)
#  group_presale        :string(3)
#  category_return_para :decimal(5, 2)
#
# Indexes
#
#  xpk_stk_grp_prs  (company_code,category_code,group_presale)
#

class DbsaleStockCategory < DbsaleBase
  self.table_name = 'STOCK_CATEGORY'
  include AliasLegacyColumns
  self.primary_keys = :category_code
end
