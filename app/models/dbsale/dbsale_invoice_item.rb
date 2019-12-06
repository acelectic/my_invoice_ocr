# == Schema Information
#
# Table name: INVOICE_ITEMS
#
#  company_code             :string(3)
#  invoice_id               :integer
#  invoice_type             :string(4)
#  invoice_series           :string(8)
#  invoice_no               :integer          primary key
#  seq_no                   :integer
#  invoice_date             :date
#  item_code                :string(40)
#  item_name                :string(255)
#  stock_type               :string(6)
#  store_id                 :string(10)
#  item_qty                 :decimal(16, 4)
#  price                    :decimal(16, 4)
#  value                    :decimal(20, 6)
#  dis_percent_1            :decimal(5, 2)
#  dis_amount_1             :decimal(20, 2)
#  dis_percent_2            :decimal(5, 2)
#  dis_amount_2             :decimal(20, 2)
#  dis_percent_3            :decimal(5, 2)
#  dis_amount_3             :decimal(20, 2)
#  dis_percent_4            :decimal(5, 2)
#  dis_amount_4             :decimal(20, 2)
#  remarks                  :string(1900)
#  net_item_value           :decimal(20, 6)
#  net_price                :decimal(20, 6)
#  reamarks                 :string(1900)
#  status                   :string(1)
#  sale_order_type          :string(4)
#  sale_order_series        :string(8)
#  sale_order_no            :integer
#  sale_order_seq_no        :integer
#  net_item_value_exclusive :decimal(24, 6)
#  net_item_value_baht      :decimal(24, 6)
#  um_code                  :string(4)
#  area_code                :string(8)
#  route_code               :string(4)
#  foc_item                 :string(1)
#  foc_qty                  :decimal(16, 4)
#  cn_qty                   :decimal(16, 4)
#  foc_um                   :string(4)
#  invoice_item_id          :integer
#  sk_rec_qty               :decimal(16, 4)
#  revision_no              :integer
#  vat_amount               :decimal(20, 6)
#  item_amount_dis          :decimal(20, 6)
#  type_of_invoice          :string(1)
#  ref_can_inv              :string(1)
#  issue_store              :string(10)
#  rtn_qty_brn              :decimal(16, 4)
#  boi_flag                 :string(1)
#  pm_tray_flag             :string(1)
#  long_qty                 :decimal(16, 4)
#  po_qty                   :decimal(16, 4)
#  po_price                 :decimal(20, 6)
#  prs_qty                  :decimal(16, 4)
#  distribute_qty           :decimal(16, 4)
#  forecast_qty             :decimal(16, 4)
#  rtn_qty                  :decimal(16, 4)
#  push_qty                 :decimal(16, 4)
#  customer_exg_qty         :decimal(16, 4)
#  vansale_exg_qty          :decimal(16, 4)
#  gen_prs_qty              :decimal(16, 4)
#
# Indexes
#
#  idx_invoice_item          (company_code,invoice_id,invoice_type,invoice_series,invoice_no,seq_no) UNIQUE
#  idx_invoice_items_i_temp  (company_code,invoice_id,invoice_item_id)
#  idx_invoice_items_tmp     (company_code,invoice_type,invoice_series,invoice_no)
#  idx_iv_items              (company_code,invoice_type,invoice_series,invoice_no,seq_no) UNIQUE
#  zz_d_inv_items_temp       (company_code,invoice_type,invoice_series,invoice_no,item_code)
#  zz_d_item_temp_date       (company_code,invoice_date,item_code,invoice_type,invoice_series,invoice_no)
#

class DbsaleInvoiceItem < DbsaleBase
  self.table_name = 'INVOICE_ITEMS'
  include AliasLegacyColumns
  self.primary_keys = :invoice_no
end
