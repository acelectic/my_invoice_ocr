# == Schema Information
#
# Table name: customer_stores
#
#  id                  :bigint           not null, primary key
#  assign_branch_name  :string(100)
#  customer_store_code :string(255)      not null
#  customer_store_name :string(255)
#  customer_store_type :string(1)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  customer_id         :integer          not null
#
# Indexes
#
#  index_customer_stores_unique  (customer_store_code) UNIQUE
#

require 'test_helper'

class CustomerStoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
