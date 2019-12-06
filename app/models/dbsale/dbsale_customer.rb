class DbsaleCustomer < DbsaleBase
    self.table_name = 'CUSTOMERS'
    include AliasLegacyColumns
    self.primary_keys = :customer_code
end