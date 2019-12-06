# == Schema Information
#
# Table name: items
#
#  id                   :bigint           not null, primary key
#  description          :string(200)
#  is_active            :boolean          default(TRUE), not null
#  is_boi               :boolean          default(TRUE), not null
#  item_code            :string(40)       not null
#  item_eng_name        :string(100)
#  item_thai_name       :string(100)      not null
#  item_type            :string(1)        not null
#  remain_code          :string(40)
#  short_name           :string(100)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  item_sub_category_id :integer
#  unit_of_measure_id   :integer          not null
#
# Indexes
#
#  index_items_on_item_code  (item_code) UNIQUE
#

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
