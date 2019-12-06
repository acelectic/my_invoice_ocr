# == Schema Information
#
# Table name: customers
#
#  id                  :bigint           not null, primary key
#  customer_code       :string(10)       not null
#  customer_short_name :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_customers_unique  (customer_code) UNIQUE
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
