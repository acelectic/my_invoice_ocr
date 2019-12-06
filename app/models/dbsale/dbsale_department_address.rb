# == Schema Information
#
# Table name: DEPARTMENT_ADDRESSES
#
#  company_code           :string(3)
#  department_code        :string(6)        primary key
#  contact_person         :string(255)
#  address                :string(500)
#  province               :string(50)
#  amphoe                 :string(50)
#  tambon                 :string(50)
#  city                   :string(50)
#  country_code           :string(10)
#  postal_code            :string(10)
#  phone_numbers          :string(40)
#  fax_numbers            :string(20)
#  email_number           :string(100)
#  remarks                :string(500)
#  created_date           :date
#  created_by             :string(10)
#  last_upd_date          :date
#  last_upd_by            :string(10)
#  tax_id                 :string(20)
#  company_name           :string(255)
#  alternate_company_name :string(255)
#  alternate_address      :string(500)
#  zone                   :string(3)
#  area_code              :string(8)
#  register               :string(1)
#  sequence               :integer
#  type_of_branch         :string(1)
#  invoice_ref            :string(30)
#  account_ref            :string(30)
#  oracle_ref             :string(30)
#  road_name              :string(50)
#  holiday_code           :string(6)
#  forecast_ref           :string(30)
#  invoice_ref_can        :string(30)
#  sub_zone_id            :integer
#
# Indexes
#
#  con_dept_adds  (company_code,department_code) UNIQUE
#  index_da       (company_code,zone,department_code)
#  zz_dept_zone   (company_code,zone)
#

class DbsaleDepartmentAddress< DbsaleBase
  self.table_name = 'DEPARTMENT_ADDRESSES'
  include AliasLegacyColumns
  self.primary_keys = :department_code
end
  