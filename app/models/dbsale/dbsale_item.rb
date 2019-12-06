# == Schema Information
#
# Table name: ITEMS
#
#  company_code            :string(3)        not null
#  item_code               :string(40)       not null, primary key
#  parent                  :string(40)
#  item_name_eng           :string(1900)
#  item_name_thai          :string(1900)
#  default_name            :string(1)
#  detailed_description    :string(1900)
#  item_um                 :string(4)
#  strength                :decimal(20, 6)
#  min_level               :decimal(20, 6)
#  max_level               :decimal(20, 6)
#  reorder_level           :decimal(20, 6)
#  reorder_qty             :decimal(20, 6)
#  obsolete_flag           :string(1)
#  stock_evaluation        :string(1)
#  approving_deptt         :string(6)
#  total_stock_qty         :decimal(20, 6)
#  total_stock_value       :decimal(16, 2)
#  month_opening_qty       :decimal(20, 6)
#  month_opening_value     :decimal(16, 2)
#  year_opening_qty        :decimal(20, 6)
#  year_opening_value      :decimal(16, 2)
#  record_type             :string(1)
#  status                  :string(1)
#  ledger_type             :string(2)
#  value_limit             :decimal(16, 2)
#  created_by              :string(20)
#  created_date            :date
#  last_upd_by             :string(20)
#  last_upd_date           :date
#  non_stock               :string(1)        default("Y")
#  non_value               :string(1)        default("Y")
#  space_occupied_per_unit :decimal(16, 4)
#  gross_weight            :decimal(16, 4)
#  net_weight              :decimal(16, 4)
#  percent_lost            :decimal(5, 2)
#  package_level           :string(8)
#  std_weight              :decimal(16, 4)
#  expiry_day              :integer
#  item_code_id            :integer
#  parent_id               :integer
#  approved_by_id          :string(20)
#  act_item                :integer
#  production_stock        :string(1)
#  category_code           :string(10)
#  sub_category_code       :string(10)
#  ckd_flag                :string(1)
#  category_code_mk        :string(10)
#  sub_category_code_mk    :string(10)
#  sub_cat_code_mk         :string(10)
#  check_run               :string(1)
#  short_name              :string(100)
#  barcode_check           :string(1)
#  discount_check          :string(1)
#  vat_check               :string(1)
#  grade                   :string(1)
#  edit_order              :string(1)
#  acc_code                :string(4)
#  um_weight               :string(4)
#  tray_flag               :string(1)        default("N")
#  remain_item_code        :string(40)
#  boi_flag                :string(1)        default("N")
#  paratroops              :string(20)
#  picture_file            :string(50)
#  target_adjust_para      :decimal(8, 2)
#  category_presale        :string(5)
#  mapped_item_code_dbcake :string(10)
#  item_cost               :decimal(10, 2)
#
# Indexes
#
#  idx_it_item_code_keys  (item_code)
#  idx_sa011a6_rep        (company_code,item_code,category_code,sub_category_code)
#  inx_cat_mk             (company_code,item_code,sub_cat_code_mk,sub_category_code_mk,category_code_mk)
#  inx_cat_tray           (company_code,item_code,sub_cat_code_mk,sub_category_code_mk,category_code_mk,tray_flag)
#  inx_item_cate          (company_code,record_type,category_code,NVL("TRAY_FLAG",'N'))
#  inx_itemtray           (company_code,item_code,sub_cat_code_mk,NVL("TRAY_FLAG",'N'))
#  zz_cate_mk             (company_code,category_code_mk,item_code,NVL("TRAY_FLAG",'N'))
#  zz_tray_flag           (company_code,NVL("TRAY_FLAG",'N'))
#

class DbsaleItem < DbsaleBase
  self.table_name = 'ITEMS'
  include AliasLegacyColumns
  self.primary_keys = :item_code
end
