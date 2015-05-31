class ProductSerializer < ActiveModel::Serializer
  attributes :page_link , :picture_link , :title ,
             :price , :old_price , :regular_price
end
