module AliasLegacyColumns
  extend ActiveSupport::Concern

  included do
    column_names.each do |cn|
      alias_attribute cn.to_s.downcase, cn unless cn.to_s == cn.to_s.downcase
    end
  end
end
