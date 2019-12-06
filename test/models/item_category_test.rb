# == Schema Information
#
# Table name: item_categories
#
#  id                 :bigint           not null, primary key
#  alternate_name     :string(20)
#  is_active          :boolean          default(TRUE), not null
#  item_category_code :string(10)       not null
#  item_category_name :string(50)       not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_item_categories_on_item_cat_code  (item_category_code) UNIQUE
#

require 'test_helper'

class ItemCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
