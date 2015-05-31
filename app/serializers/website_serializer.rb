class WebsiteSerializer < ActiveModel::Serializer
  attributes :num_of_products , :products
  has_one :home_page

  def products
    @user = User.find(@options[:user_id])
    @user.popularities.limit(object.num_of_products).each {|p| @products || Product.none << p.product} if @user
    @products
  end

end
