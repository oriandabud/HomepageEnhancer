class HomePageSerializer < ActiveModel::Serializer
  attributes :product_name_selector, :product_url_selector , :product_price_selector ,
             :product_old_price_selector , :product_container_selector , :product_picture_selector,
             :img_max_width , :img_max_height
end
