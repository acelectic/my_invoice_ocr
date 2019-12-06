# == Schema Information
#
# Table name: DEPARTMENTS
#
#  company_code        :string(3)        not null
#  department_code     :string(6)        not null, primary key
#  department_desc     :string(50)
#  alternate_name      :string(50)
#  created_by          :string(20)
#  status              :string(1)
#  last_upd_by         :string(20)
#  created_date        :date
#  last_upd_date       :date
#  department_ref      :string(10)       not null
#  cost_center_code    :string(10)
#  dir_exp             :string(1900)
#  dir_imp             :string(1900)
#  last_imp_date       :date
#  dir_exp_off         :string(1900)
#  dir_imp_off         :string(1900)
#  last_imp_iss_date   :date
#  last_imp_invbr_date :date
#  last_post_date      :date
#  remarks             :string(255)
#  dir_picture_file    :string(1900)
#  flag_presale        :string(2)
#  holiday_flag        :string(1)
#  pre_order_flag      :string(1)
#  modify_flag         :string(1)
#  add_deduct_flag     :string(1)
#  prs_from_date       :date
#  prs_to_date         :date
#
# Indexes
#
#  index_dept       (company_code,cost_center_code,department_code)
#  xpk_departments  (company_code,department_code) UNIQUE
#

class DbsaleDepartment< DbsaleBase
  self.table_name = 'DEPARTMENTS'
  include AliasLegacyColumns
  self.primary_keys = :department_code
end
