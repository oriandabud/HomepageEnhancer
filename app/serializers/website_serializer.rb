class WebsiteSerializer < ActiveModel::Serializer
  attributes :num_of_products , :products
  has_one :home_page

  def products
    @user = User.find(@options[:user_id])
    @products = Product.all.limit(0)
    @user.popularities.limit(object.num_of_products).each {|p| @products << p.product} if @user
    @products += object.products.limit(object.num_of_products - (@product.try(:length)|| 0))
    @products
  end

end
