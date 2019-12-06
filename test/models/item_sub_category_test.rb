# == Schema Information
#
# Table name: item_sub_categories
#
#  id                     :bigint           not null, primary key
#  is_active              :boolean          not null
#  item_sub_category_code :string(10)       not null
#  item_sub_category_name :string(50)       not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  item_category_id       :integer          not null
#
# Indexes
#
#  idx_item_cat_on_item_cat_id_and_item_sub_cat_code    (item_category_id,item_sub_category_code) UNIQUE
#  index_item_sub_categories_on_item_sub_category_code  (item_sub_category_code)
#

require 'test_helper'

class ItemSubCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
