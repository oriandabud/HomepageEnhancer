class PageViewController < ApplicationController
  befor_action :set_user , only [:create]
  befor_action :set_website , only [:create]

  # POST /websites
  # POST /websites.json
  def create
    if is_product?
      set_product
      popularities = @product.popularities.where(user: @user)
      popularities.each {|p| p.entrances+= 2}
      render nothing: true, status: 204
    elsif is_category?
      set_category
      @category.products.each do |product|
        popularities = product.popularities.where(user: @user)
        popularities.each {|p| p.entrances+= 1}
      end
      render nothing: true, status: 204
    else
      render nothing: true, status: 204 # todo report bad selector on page
    end

  end

  private

  def is_product?
    identify = @website.category_identify
    recommandation_params[:url].includ? identifier
  end

  def is_category?
    identifier = @website.product_identify
    recommandation_params[:url].includ? identifier
  end

  def set_website
    recommandation_params[:url] # todo: set website by full url
  end

  def set_product
    @product = Product.find_by_page_link(:url) || Product.new(recommandation_params[:url])
  end

  def set_category
    @category = Category.find_by_page_link(:url) || Category.new(recommandation_params[:url])
  end

  def set_user
    @user = User.find(params[:uuid])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recommandation_params
    params.require(:recommandation).permit(:url, :uuid)
  end
end
