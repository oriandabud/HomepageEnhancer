class PageViewController < ApplicationController
  # POST /websites
  # POST /websites.json
  def create
    @popularities = @product.popularities.where(user: @user)
    @popularities.each {|p| p.entrances+= 1}
    render nothing: true, status: 204
  end

  private

  def set_product
    @product = Product.find_by_page_link(:url) || Product.new(recommandation_params[:url])
  end

  def set_user
    @user = User.find(params[:uuid])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recommandation_params
    params.require(:recommandation).permit(:url, :uuid)
  end
end
