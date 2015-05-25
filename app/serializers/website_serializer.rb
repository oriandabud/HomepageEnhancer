class WebsiteSerializer < ActiveModel::Serializer
  attributes :num_of_products , :products
  has_one :home_page

  def products
    @user = User.find(@options[:user_id])
    @user.popularities.limit(@website.num_of_products).each {|p| @products << p.product} if @user
    @products += @website.products.limit(@website.num_of_products - (@product.try(:length)|| 0))
    @products
  end

end
