class AddAssignBranchNameToCustomerStore < ActiveRecord::Migration[6.0]
  
  def up
    add_column :customer_stores, :assign_branch_name, :string, limit: 100
  end

  def down
    remove_column :customer_stores, :assign_branch_name
  end

end
