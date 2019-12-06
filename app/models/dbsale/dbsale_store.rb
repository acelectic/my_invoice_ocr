# == Schema Information
#
# Table name: STORES
#
#  company_code        :string(3)        not null
#  store_ref           :integer          not null
#  department_code     :string(6)        not null
#  alternate_name      :string(225)
#  status              :string(1)
#  remarks             :string(1900)
#  created_by          :string(20)
#  created_date        :date
#  last_upd_by         :string(20)
#  last_upd_date       :date
#  store_id            :string(10)       not null, primary key
#  description         :string(255)
#  location_code       :string(10)
#  voucher_series      :string(8)
#  cost_center         :string(4)
#  record_type         :string(1)
#  plant_code          :string(4)
#  building_code       :string(6)
#  branch_code         :string(3)
#  store_code          :string(4)
#  factory_ref         :string(30)
#  default_store       :string(1)
#  route_code          :string(5)
#  last_imp_date       :date
#  posting_date        :date
#  gen_pay             :string(1)
#  last_imp_invbr_date :date
#  round_code          :string(6)
#  type_store          :string(1)        default("P")
#  psale_user_edit     :string(1)
#  psale_last_day      :string(2)
#  psale_promotion     :string(2)
#  number_day_visit    :boolean          default(TRUE)
#  online_route_flag   :boolean          default(FALSE)
#
# Indexes
#
#  idx_st_store_id_keys  (store_id)
#  idx_stores_ac2050     (company_code,department_code,store_id,description)
#  index_stores          (company_code,department_code,store_code)
#  pk_store              (company_code,store_id) UNIQUE
#  zz_store_bld_type     (company_code,building_code,record_type)
#  zz_store_building     (company_code,building_code)
#  zz_store_type         (company_code,record_type,default_store)
#

class DbsaleStore< DbsaleBase
  self.table_name = 'STORES'
  include AliasLegacyColumns
  self.primary_keys = :store_id
end
