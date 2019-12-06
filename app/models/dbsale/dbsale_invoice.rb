# == Schema Information
#
# Table name: INVOICES
#
#  invoice_id             :integer
#  company_code           :string(3)
#  invoice_type           :string(4)        primary key
#  invoice_series         :string(8)        primary key
#  invoice_no             :integer          primary key
#  invoice_date           :date
#  sale_order_type        :string(4)
#  sale_order_series      :string(8)
#  sale_order_no          :integer
#  customer_code          :string(10)
#  customer_name          :string(500)
#  address_code           :integer
#  delivery_address       :string(500)
#  city                   :string(20)
#  country                :string(20)
#  cost_center_code       :string(4)
#  department_code        :string(6)
#  salesman_code          :string(10)
#  vat_code               :string(4)
#  vat_inclusive          :string(1)
#  vat_invoice_no         :string(22)
#  vat_percent            :decimal(5, 2)
#  vat_amount             :decimal(16, 2)
#  price_method           :string(8)
#  invoice_due_date       :date
#  truck_number           :string(10)
#  driver_id              :string(15)
#  driver_name            :string(50)
#  cost_of_goods          :decimal(16, 2)
#  payment_received       :decimal(16, 2)
#  net_invoice_value_baht :decimal(16, 2)
#  status                 :string(1)
#  created_by             :string(20)
#  created_date           :date
#  last_upd_by            :string(20)
#  last_upd_date          :date
#  remarks                :string(1900)
#  delivery_date          :date
#  area_code              :string(8)
#  route_code             :string(4)
#  credit_period          :integer
#  type_of_invoice        :string(1)
#  store_id               :string(10)
#  mark_invoice           :string(1)
#  confirm_date           :date
#  reason_code            :string(15)
#  arstmt_recid           :integer
#  mark_ar                :string(1)        default("N")
#  other_dis_percent      :decimal(5, 2)
#  other_dis_amount       :decimal(16, 2)
#  ref_can_inv            :string(1)        default("N")
#  ref_inv_type           :string(4)
#  ref_inv_series         :string(15)
#  ref_inv_no             :integer
#  confirm_date_ar        :date
#  reason_code_ar         :string(15)
#  type_return            :string(1)
#  remarks_mark           :string(1900)
#  product_group          :string(8)
#  revision_no            :integer
#  document_date          :date
#  type_inv               :string(1)
#  unconfirm_date         :date
#  unconfirm_date_ar      :date
#  no_of_follow           :integer
#  transfer_ar            :string(1)        default("N")
#  no_of_follow_ar        :integer
#  remarks_mark_ar        :string(1900)
#  return_bill_ar         :string(1)        default("N")
#  refer_dept_ar          :string(6)
#  reason_code_inv        :string(15)
#  st_amt                 :decimal(16, 2)
#  monthly_stock          :integer
#  ref_gen_type           :string(4)
#  ref_gen_series         :string(8)
#  ref_gen_no             :string(10)
#  ref_gen_seq_no         :integer
#  dept_seq               :string(2)
#  mark_diliya            :string(1)
#  issue_store            :string(10)
#  customer_po_number     :string(255)
#  service_flag           :string(1)
#  mark_control_inv       :string(1)        default("N")
#  total_cash             :decimal(16, 2)
#  total_cr_card          :decimal(16, 2)
#  total_coupon           :decimal(16, 2)
#  total_adv              :decimal(16, 2)
#  rec_cash               :decimal(16, 2)
#  rec_cr_card            :decimal(16, 2)
#  rec_coupon             :decimal(16, 2)
#  rec_adv                :decimal(16, 2)
#  po_flag                :string(1)
#  hh_time                :string(10)
#  no_of_bill             :decimal(16, 2)
#  po_number_map          :string(255)
#  cust_card_id           :string(20)
#  register               :string(1)
#  branch_no              :string(50)
#  tax_id                 :string(50)
#  date_received          :date
#  ref_over_due_amt       :decimal(16, 2)
#  ref_over_due_update    :date
#  payment_method_id      :boolean
#  payment_method_ref     :string(20)
#
# Indexes
#
#  idx_ind                    (company_code,invoice_type,invoice_series,invoice_no) UNIQUE
#  idx_inv_dd_p_tmp           (company_code,invoice_date,cost_center_code,department_code,customer_code)
#  idx_inv_ddref_p_tmp        (company_code,invoice_date,cost_center_code,department_code,refer_dept_ar)
#  idx_inv_id_p_tmp           (company_code,monthly_stock,invoice_date)
#  idx_inv_invdate_p_tmp      (company_code,invoice_date)
#  idx_inv_map                (invoice_date,customer_code,customer_po_number)
#  idx_inv_pbitem             (company_code,ref_gen_type,ref_gen_series,ref_gen_no,invoice_date)
#  idx_inv_rar_p_tmp          (company_code,department_code,store_id,confirm_date_ar,refer_dept_ar)
#  idx_inv_store_date_p_temp  (company_code,store_id,invoice_date)
#  idx_inv_vat_p_tmp          (company_code,vat_invoice_no)
#  idx_invoice                (company_code,invoice_id,invoice_type,invoice_series,invoice_no) UNIQUE
#  idx_rep_ar5005f            (company_code,cost_center_code,invoice_date,type_of_invoice,status)
#  pk_invoice_id_p_tmp        (company_code,invoice_id)
#  rep_p_tmp                  (company_code,invoice_type,invoice_series,invoice_no,invoice_date,cost_center_code,store_id)
#  zz_cc_store_date_p_tmp     (company_code,cost_center_code,store_id,invoice_date)
#  zz_inv_app_date_p_tmp      (company_code,issue_store,last_upd_date)
#  zz_inv_cc_dept_p_tmp       (company_code,cost_center_code,department_code,invoice_date)
#  zz_inv_date_p_tmp          (company_code,invoice_date,cost_center_code,store_id)
#  zz_invoice_aci0004_p_tmp   (company_code,invoice_date,store_id)
#  zz_rep_p_tmp               (company_code,cost_center_code,customer_code,invoice_date,invoice_type,invoice_series,invoice_no)
#

class DbsaleInvoice < DbsaleBase
    self.table_name = 'INVOICES'
    include AliasLegacyColumns
    self.primary_keys = :invoice_type, :invoice_series, :invoice_no
  
    attribute :payment_method_id, :integer
  
    def self.generate_bill_history
  
      master_path = Rails.root.join("public", "presale_masters", DateTime.now.strftime("%d-%m-%Y"))
  
      FileUtils.mkdir_p master_path unless File.directory?(master_path)
  
      all_stores = DbsaleInvoice.select(:store_id).group(:store_id)
  
      all_stores.each do |store|
        bill_file = Rails.root.join(master_path, store.to_s + ".BH")
        File.write(bill_file, '')
          bill_histories = DbsaleInvoice.find_by_sql(%Q{
            SELECT CUSTOMER_CODE || '|' || ITEM_CODE || '|' || SALE_DATE || '|' || SALE_QTY || '|' || RTN_QTY AS RESULTS FROM
                (SELECT INVOICES.CUSTOMER_CODE, INVOICE_ITEMS.ITEM_CODE,
                  LISTAGG(COALESCE(TO_CHAR(INVOICES.INVOICE_DATE, 'DD/MM/YYYY'),'-'), ',') WITHIN GROUP (ORDER BY INVOICES.INVOICE_DATE) AS SALE_DATE,
                  LISTAGG(COALESCE(INVOICE_ITEMS.ITEM_QTY,0), ',') WITHIN GROUP (ORDER BY INVOICES.INVOICE_DATE) AS SALE_QTY,
                  LISTAGG(COALESCE(INVOICE_ITEMS.RTN_QTY_BRN,0), ',') WITHIN GROUP (ORDER BY INVOICES.INVOICE_DATE) AS RTN_QTY
                FROM INVOICES
                LEFT JOIN (SELECT DISTINCT * FROM INVOICE_ITEMS) INVOICE_ITEMS ON INVOICES.VAT_INVOICE_NO = INVOICE_ITEMS.INVOICE_SERIES || LPAD(INVOICE_ITEMS.INVOICE_NO, 4, '0')
                WHERE INVOICES.CUSTOMER_CODE IN (SELECT DISTINCT CUSTOMER_CODE FROM INVOICES
                  WHERE INVOICES.STORE_ID = #{store.store_id})
                AND INVOICES.INVOICE_DATE BETWEEN TO_DATE('01/11/2017', 'DD/MM/YYYY') AND TO_DATE('30/11/2017', 'DD/MM/YYYY')
                GROUP BY INVOICES.CUSTOMER_CODE, INVOICE_ITEMS.ITEM_CODE
                ORDER BY INVOICES.CUSTOMER_CODE ASC)
            }).map(&:results).join("\n")
          File.open(bill_file, 'a') {|f| f.puts bill_histories }
        end
    end
end
  