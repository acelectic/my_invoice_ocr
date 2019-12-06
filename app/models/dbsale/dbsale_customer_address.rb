class DbsaleCustomerAddress< DbsaleBase
  self.table_name = 'CUSTOMER_ADDRESSES'
  include AliasLegacyColumns
  include ActiveModel::Dirty
  self.primary_keys = :customer_code, :address_code

  attribute :created_date, :datetime
  attribute :last_upd_date, :datetime
end