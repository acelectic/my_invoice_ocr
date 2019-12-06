# == Schema Information
#
# Table name: item_unit_of_measures
#
#  id           :bigint           not null, primary key
#  item_um_code :string(4)        not null
#  item_um_name :string(255)      not null
#  status       :string(1)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_item_unit_of_measures_on_item_um_code  (item_um_code) UNIQUE
#

require 'test_helper'

class ItemUnitOfMeasureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
