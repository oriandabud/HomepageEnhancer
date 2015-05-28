class ProductPageSerializer < ActiveModel::Serializer
  attributes :name_selector , :picture_selector , :price_selector ,
             :old_price_selector , :validator_selector
end
