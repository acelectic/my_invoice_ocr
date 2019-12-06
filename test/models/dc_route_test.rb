# == Schema Information
#
# Table name: dc_routes
#
#  id                     :bigint           not null, primary key
#  building_code          :string(10)
#  customer_branch_code   :string(5)
#  dc_route_code          :string(10)       not null
#  dc_route_name          :string(80)       not null
#  is_active              :boolean          default(TRUE), not null
#  is_factory             :boolean
#  operation_type         :string(50)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  distribution_center_id :integer          not null
#  plant_id               :integer
#
# Indexes
#
#  index_dc_routes_on_dc_route_code           (dc_route_code) UNIQUE
#  index_dc_routes_on_distribution_center_id  (distribution_center_id)
#

require 'test_helper'

class DcRouteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
