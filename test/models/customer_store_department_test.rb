# == Schema Information
#
# Table name: customer_store_departments
#
#  id                     :bigint           not null, primary key
#  sale_date              :date             not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  customer_store_id      :integer          not null
#  dc_route_id            :integer          not null
#  distribution_center_id :integer          not null
#
# Indexes
#
#  index_customer_store_departments_unique  (dc_route_id,distribution_center_id,customer_store_id) UNIQUE
#

require 'test_helper'

class CustomerStoreDepartmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
