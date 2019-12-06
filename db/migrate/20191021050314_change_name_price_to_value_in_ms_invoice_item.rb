class ChangeNamePriceToValueInMsInvoiceItem < ActiveRecord::Migration[6.0]
  
  def up
    rename_column :ms_invoice_items, :price, :value
  end

  def down
    rename_column :ms_invoice_items, :value, :price
  end

end
